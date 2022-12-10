import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';

abstract class SearchMovieState extends Equatable {
  SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieEmpty extends SearchMovieState {}
class SearchMovieLoading extends SearchMovieState {}

class SearchMovieError extends SearchMovieState {
  final String message;
  SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieHasData extends SearchMovieState {
  final List<Movie> result;
  SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
