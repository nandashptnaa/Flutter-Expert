import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvPopularNotifier extends ChangeNotifier{
  final GetPopularTvSeries getTvPopular;
  TvPopularNotifier(this.getTvPopular);

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _popularTv =[];
  List<TvSeries> get popularTv => _popularTv;

  Future<void> fetchPopularTvsEries() async{
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (message) {
      _state = RequestState.Loaded;
      _popularTv = message;
      notifyListeners();
    });
  }


}