import 'package:equatable/equatable.dart';

abstract class SearchTvEvent extends Equatable {
  SearchTvEvent();

  @override
  List<Object> get props => [];
}

class OnTvQueryChanged extends SearchTvEvent {
  final String query;
  OnTvQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}