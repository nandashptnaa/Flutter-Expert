import 'package:equatable/equatable.dart';

abstract class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();
}

class FetchTvseriesData extends TvSeriesEvent {
  const FetchTvseriesData();

  @override
  List<Object> get props => [];
}

class FetchTvseriesDataWithId extends TvSeriesEvent {
  final int id;
  const FetchTvseriesDataWithId(this.id);

  @override
  List<Object> get props => [id];
}