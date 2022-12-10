import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailState extends Equatable {
  final TvSeriesDetail? tvseriesDetail;
  final String watchlistTvMessage;
  final bool isAddedToWatchlist;
  final RequestState tvState;

  const TvDetailState({
    required this.tvseriesDetail,
    required this.watchlistTvMessage,
    required this.isAddedToWatchlist,
    required this.tvState,
  });

  TvDetailState copyWith({
    TvSeriesDetail? tvseriesDetail,
    String? watchlistTvMessage,
    bool? isAddedToWatchlist,
    RequestState? tvState,
  }) {
    return TvDetailState(
      tvseriesDetail: tvseriesDetail ?? this.tvseriesDetail,
      watchlistTvMessage: watchlistTvMessage ?? this.watchlistTvMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      tvState: tvState ?? this.tvState,
    );
  }

  factory TvDetailState.initial() {
    return const TvDetailState(
      tvseriesDetail: null,
      watchlistTvMessage: '',
      isAddedToWatchlist: false,
      tvState: RequestState.Empty,
    );
  }

  @override
  List<Object> get props => [
        watchlistTvMessage,
        isAddedToWatchlist,
        tvState,
      ];
}
