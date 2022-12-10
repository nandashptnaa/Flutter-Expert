import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  SearchMovieEvent();
}

class OnMovieQueryChanged extends SearchMovieEvent {
  final String query;
  OnMovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}