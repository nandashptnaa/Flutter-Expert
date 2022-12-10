import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListMovieStatus;
  final SaveWatchlist saveWatchlistMovie;
  final RemoveWatchlist removeWatchlistMovie;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getWatchListMovieStatus,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetailById>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.Loading));
      final detailResult = await getMovieDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(movieDetailState: RequestState.Error));
        },
        (movie) async {
          emit(state.copyWith(
            movieDetailState: RequestState.Loaded,
            movieDetail: movie,
          ));
        },
      );
    });
    on<AddMovieWatchlist>((event, emit) async {
      final result = await saveWatchlistMovie.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMovie: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMovie: successMessage));
      });

      add(WatchlistMovieStatus(event.movieDetail.id));
    });
    on<RemoveMovieWatchlist>((event, emit) async {
      final result = await removeWatchlistMovie.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMovie: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMovie: successMessage));
      });

      add(WatchlistMovieStatus(event.movieDetail.id));
    });
    on<WatchlistMovieStatus>((event, emit) async {
      final result = await getWatchListMovieStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
