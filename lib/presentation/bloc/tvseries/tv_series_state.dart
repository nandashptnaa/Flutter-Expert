import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesState extends Equatable {
  TvSeriesState();

  @override
  List<Object> get props => [];
}

class EmptyTvData extends TvSeriesState {}
class LoadingTvData extends TvSeriesState {}

class ErrorTvData extends TvSeriesState {
  final String message;
  ErrorTvData(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedTvData extends TvSeriesState {
  final List<TvSeries> result;
  LoadedTvData(this.result);

  @override
  List<Object> get props => [result];
}
