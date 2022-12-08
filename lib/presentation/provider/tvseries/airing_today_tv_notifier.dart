import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_airing_today_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvAiringTodayNotifier extends ChangeNotifier {
  final GetAiringTodayTvSeries getTv;
  TvAiringTodayNotifier({required this.getTv});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _airingToday = [];
  List<TvSeries> get airingToday => _airingToday;

  Future<void> fetchAiringToday() async {
    final result = await getTv.execute();
    result.fold(
            (failure) {
              _state = RequestState.Error;
              _message = failure.message;
              notifyListeners();
            },
            (dataTv) {
              _state = RequestState.Loaded;
              _airingToday = dataTv;
              notifyListeners();
            });
  }
}
