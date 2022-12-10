import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  MovieDetailEvent();
}

class FetchMovieDetailById extends MovieDetailEvent {
  final int id;
  FetchMovieDetailById(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
  AddMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class WatchlistMovieStatus extends MovieDetailEvent {
  final int id;
  WatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveMovieWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
  RemoveMovieWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}