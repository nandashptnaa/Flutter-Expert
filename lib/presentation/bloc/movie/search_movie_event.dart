import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  SearchMovieEvent();
}

class MovieQueryChanged extends SearchMovieEvent {
  final String query;
  MovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}