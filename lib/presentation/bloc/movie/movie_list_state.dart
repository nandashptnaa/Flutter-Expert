import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';


abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class EmptyData extends MovieListState {}
class LoadingData extends MovieListState {}

class ErrorData extends MovieListState {
  final String message;
  const ErrorData(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MovieListState {
  final List<Movie> result;
  const MovieListHasData(this.result);

  @override
  List<Object> get props => [result];
}