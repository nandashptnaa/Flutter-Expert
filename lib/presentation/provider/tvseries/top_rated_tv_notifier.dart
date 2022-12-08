import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:flutter/material.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvNotifier({required this.getTopRatedTvSeries});

  RequestState _tvTopRatedState = RequestState.Empty;
  RequestState get state => _tvTopRatedState;

  List<TvSeries> _tvTopRated = [];
  List<TvSeries> get tvTopRated => _tvTopRated;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _tvTopRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _tvTopRatedState = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _tvTopRated = moviesData;
        _tvTopRatedState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
