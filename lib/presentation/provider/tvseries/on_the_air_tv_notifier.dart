
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvOnTheAirNotifier extends ChangeNotifier{
  final GetOnTheAirTvSeries getTvOnTheAir;

  TvOnTheAirNotifier({required this.getTvOnTheAir});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tv = [];
  List<TvSeries> get tv => _tv;

  Future<void> fetchTvOnTheAir()async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (tvData) {
      _tv = tvData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

}