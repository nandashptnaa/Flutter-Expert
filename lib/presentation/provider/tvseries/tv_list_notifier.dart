
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_airing_today_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier{

  final GetAiringTodayTvSeries getAiringTodayTv;
  final GetOnTheAirTvSeries getOnTheAirTv;
  final GetPopularTvSeries getPopularTv;
  final GetTopRatedTvSeries getTopRatedTv;

  TvListNotifier({
    required this.getOnTheAirTv,
    required this.getAiringTodayTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  String _message = '';
  String get message => _message;

  var _airingTodayTv = <TvSeries>[];
  List<TvSeries> get airingTodayTv => _airingTodayTv;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _onTheAirTv = <TvSeries>[];
  List<TvSeries> get onTheAirTv => _onTheAirTv;

  RequestState _onTheAirTvState = RequestState.Empty;
  RequestState get onTheAirTvState => _onTheAirTvState;

  var _popularTv = <TvSeries>[];
  List<TvSeries> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <TvSeries>[];
  List<TvSeries> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  Future<void> fetchAiringToday() async{
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTv.execute();
    result.fold((failure) {
      _airingTodayState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (dataTv) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTv = dataTv;
        notifyListeners();
    });
  }


  Future<void> fetchOnTheAir() async{
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();
    result.fold((failure) {
      _onTheAirTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _onTheAirTvState = RequestState.Loaded;
      _onTheAirTv = data;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTv() async{
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
            (failure) {
              _popularTvState = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            }, (data) {
              _popularTvState = RequestState.Loaded;
              _popularTv = data;
              notifyListeners();
    });
  }

  Future<void> fetchTopRatedTv() async{
    _topRatedTvState = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedTv.execute();
    result.fold(
            (failure) {
              _topRatedTvState = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            }, (data) {
              _topRatedTvState = RequestState.Loaded;
              _topRatedTv = data;
              notifyListeners();
            });
  }
}