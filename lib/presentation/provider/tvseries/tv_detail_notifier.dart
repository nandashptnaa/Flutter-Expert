import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:ditonton/domain/usecases/tvseries/get_detail_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tvseries/save_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class TvDetailNotifier extends ChangeNotifier{
  static const  watchlistAddSuccessMessage = 'Added to watchlist';
  static const  watchlistRemoveSuccessMessage = 'Remove from watchlist';


  final GetTvSeriesRecommendations getTvRecommendations;
  final GetTvSeriesDetail getTvSeriesDetail;
  final SaveWatchlistTvSeries saveWatchlistTv;
  final GetWatchlistStatusTvSeries getWatchlistStatusTv;
  final RemoveWatchlistTvSeries removeWatchlistTv;

  TvDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getWatchlistStatusTv,
    required this.removeWatchlistTv,
    required this.saveWatchlistTv,
    required this.getTvRecommendations,
  });

  String _message = '';
  String get message => _message;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  late TvSeriesDetail _tvDetail;
  TvSeriesDetail get tvDetail => _tvDetail;

  bool _isAddedToWatchListTv = false;
  bool get isAddedToWatchListTv => _isAddedToWatchListTv;
  String _watchlistMessageTv = '';
  String get watchlistMessageTv => _watchlistMessageTv;

  List<TvSeries> _tvRecommendation = [];
  List<TvSeries> get tvRecommendation => _tvRecommendation;

  RequestState _tvRecommendationState = RequestState.Empty;
  RequestState get tvRecommendationState => _tvRecommendationState;


  Future<void> fetchTvSeriesDetail(int id) async{
    _tvDetailState = RequestState.Loading;
    notifyListeners();

    final detailTvResult = await getTvSeriesDetail.execute(id);
    final tvRecommendationResult = await getTvRecommendations.execute(id);

    detailTvResult.fold((failure) {
      _tvDetailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _tvRecommendationState = RequestState.Loading;
      _tvDetail = data;
      notifyListeners();
      _tvDetailState = RequestState.Loaded;
      notifyListeners();
      tvRecommendationResult.fold((failure) {
        _tvRecommendationState = RequestState.Error;
        _message = failure.message;
      }, (message) {
        _tvRecommendationState = RequestState.Loaded;
        _tvRecommendation = message;
      });
    });
  }

  Future<void> addWatchlist(TvSeriesDetail tvDetail)async{
    final result = await saveWatchlistTv.execute(tvDetail);
    await result.fold((failure) {
      _watchlistMessageTv = failure.message;
    }, (success) {
      _watchlistMessageTv = success;
    });
    await loadWatchlistStatusTv(tvDetail.id);
  }

  Future<void> loadWatchlistStatusTv(int id) async{
    final result = await getWatchlistStatusTv.execute(id);
    _isAddedToWatchListTv = result;
    notifyListeners();
  }

  Future<void> removeFromWatchlistTv(TvSeriesDetail tvDetail)async{
    final result = await removeWatchlistTv.execute(tvDetail);
    await result.fold((failure) {
      _watchlistMessageTv = failure.message;
    }, (success) {
      _watchlistMessageTv = success;
    });
    await loadWatchlistStatusTv(tvDetail.id);
  }
}