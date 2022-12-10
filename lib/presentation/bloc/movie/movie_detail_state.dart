import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final String watchlistMovie;
  final bool isAddedToWatchlist;
  final RequestState movieDetailState;

  const MovieDetailState({
    required this.movieDetail,
    required this.watchlistMovie,
    required this.isAddedToWatchlist,
    required this.movieDetailState,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    String? watchlistMovie,
    bool? isAddedToWatchlist,
    RequestState? movieDetailState,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      watchlistMovie: watchlistMovie ?? this.watchlistMovie,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      movieDetailState: movieDetailState ?? this.movieDetailState,
    );
  }

  factory MovieDetailState.initial() {
    return MovieDetailState(
      movieDetail: null,
      watchlistMovie: '',
      isAddedToWatchlist: false,
      movieDetailState: RequestState.Empty,
    );
  }

  @override
  List<Object> get props => [
        watchlistMovie,
        isAddedToWatchlist,
        movieDetailState,
      ];
}
