import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  MovieListEvent();
}

class FetchMoviesData extends MovieListEvent {
  FetchMoviesData();

  @override
  List<Object> get props => [];
}

class FetchMovieById extends MovieListEvent {
  final int id;
  FetchMovieById(this.id);

  @override
  List<Object> get props => [id];
}