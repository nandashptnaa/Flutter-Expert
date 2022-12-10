import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:equatable/equatable.dart';

abstract class SearchTvState extends Equatable {
  SearchTvState();

  @override
  List<Object> get props => [];
}

class SearchTvEmpty extends SearchTvState {}
class SearchTvLoading extends SearchTvState {}

class SearchTvError extends SearchTvState {
  final String message;
  SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends SearchTvState {
  final List<TvSeries> result;
  SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
