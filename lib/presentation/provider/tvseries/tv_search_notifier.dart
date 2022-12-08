
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvSearchNotifier extends ChangeNotifier{
  final SearchTvSeries searchTv;
  TvSearchNotifier({required this.searchTv});

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResultTv = [];
  List<TvSeries> get searchResultTv => _searchResultTv;

  Future<void> fetchSearchTv(String query) async{
    _state = RequestState.Loading;
    notifyListeners();
    final result = await searchTv.execute(query);
    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (data){
      _searchResultTv = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

}