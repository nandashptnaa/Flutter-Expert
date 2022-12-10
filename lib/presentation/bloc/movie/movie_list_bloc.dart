import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieListBloc(this._getNowPlayingMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (moviesData) {
          emit(MovieListHasData(moviesData));
        },
      );
    });
  }
}

class PopularMovieBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (moviesData) {
          emit(MovieListHasData(moviesData));
        },
      );
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetTopRatedMovies _getTopRatedMovies;
  
  TopRatedMovieBloc(this._getTopRatedMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (moviesData) {
          emit(MovieListHasData(moviesData));
        },
      );
    });
  }
}

class MovieRecommendationsBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations) : super(EmptyData()) {
    on<FetchMovieById>((event, emit) async {
      final id = event.id;
      emit(LoadingData());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (moviesData) {
          emit(MovieListHasData(moviesData));
        },
      );
    });
  }
}

class WatchlistMovieBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetWatchlistMovies _getWatchlistMovies;
  
  WatchlistMovieBloc(this._getWatchlistMovies) : super(EmptyData()) {
    on<FetchMoviesData>((event, emit) async {
      emit(LoadingData());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(ErrorData(failure.message));
        },
        (moviesData) {
          emit(MovieListHasData(moviesData));
        },
      );
    });
  }
}
