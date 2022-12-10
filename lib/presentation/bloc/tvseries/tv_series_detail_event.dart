import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  TvDetailEvent();
}

class FetchTvseriesDetailById extends TvDetailEvent {
  final int id;
  FetchTvseriesDetailById(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvWatchlist extends TvDetailEvent {
  final TvSeriesDetail tvseriesDetail;
  AddTvWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class RemoveTvWatchlist extends TvDetailEvent {
  final TvSeriesDetail tvseriesDetail;
  RemoveTvWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class LoadTvWatchlistStatus extends TvDetailEvent {
  final int id;
  LoadTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
