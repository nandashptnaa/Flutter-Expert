import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tvseries/get_detail_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_detail_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailBloc
    extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvSeriesDetail getTvseriesDetail;
  final GetWatchlistStatusTvSeries getTvWatchListStatus;
  final SaveWatchlistTvSeries saveTvWatchlist;
  final RemoveWatchlistTvSeries removeTvWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Tv Series Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Tv Series Watchlist';

  TvDetailBloc({
    required this.getTvseriesDetail,
    required this.getTvWatchListStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  }) : super(TvDetailState.initial()) {
    on<FetchTvseriesDetailById>((event, emit) async {
      emit(state.copyWith(tvState: RequestState.Loading));
      final detailResult = await getTvseriesDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(tvState: RequestState.Error));
        },
        (tvseries) async {
          emit(state.copyWith(
            tvseriesDetail: tvseries,
            tvState: RequestState.Loaded,
          ));
        },
      );
    });
    on<AddTvWatchlist>((event, emit) async {
      final result = await saveTvWatchlist.execute(event.tvseriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistTvMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistTvMessage: successMessage));
      });

      add(TvWatchlistStatusHasData(event.tvseriesDetail.id));
    });
    on<RemoveTvWatchlist>((event, emit) async {
      final result = await removeTvWatchlist.execute(event.tvseriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistTvMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistTvMessage: successMessage));
      });

      add(TvWatchlistStatusHasData(event.tvseriesDetail.id));
    });
    on<TvWatchlistStatusHasData>((event, emit) async {
      final result = await getTvWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
