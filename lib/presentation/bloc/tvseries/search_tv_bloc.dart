import 'package:ditonton/domain/usecases/tvseries/search_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/search_tv_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/search_tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchTvSeriesBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvSeries _searchTvseries;

  SearchTvSeriesBloc(this._searchTvseries) : super(SearchTvEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvLoading());
      final result = await _searchTvseries.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (SearchTvdata) {
          emit(SearchTvHasData(SearchTvdata));
        },
      );
    }, transformer: debounce(Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
