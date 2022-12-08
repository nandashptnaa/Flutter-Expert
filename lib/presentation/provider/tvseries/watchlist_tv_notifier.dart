
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvNotifier extends ChangeNotifier{
  var _watchlistTv = <TvSeries>[];
  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistStateTv = RequestState.Empty;
  RequestState get watchlistStateTv => _watchlistStateTv;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTv});
  final GetWatchlistTvSeries getWatchlistTv;

  Future<void> fetchWatchlistTv()async{
    _watchlistStateTv = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold((failure) {
      _watchlistStateTv = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _watchlistStateTv = RequestState.Loaded;
      _watchlistTv = data;
      notifyListeners();
    });
  }
}