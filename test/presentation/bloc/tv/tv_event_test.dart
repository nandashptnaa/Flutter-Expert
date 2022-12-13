import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when the props are the same as the input do a check!', () {
    expect([], const FetchTvSeriesData().props);
    expect([1], const FetchTvSeriesById(1).props);
  });
}