import 'package:equatable/equatable.dart';

abstract class TvSeriesEvent extends Equatable {
  const TvSeriesEvent();
}

class FetchTvSeriesData extends TvSeriesEvent {
  const FetchTvSeriesData();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDataWithId extends TvSeriesEvent {
  final int id;
  const FetchTvSeriesDataWithId(this.id);

  @override
  List<Object> get props => [id];
}