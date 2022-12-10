import 'package:ditonton/presentation/bloc/tvseries/tv_series_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([1], FetchTvseriesDetailById(1).props);
    expect([testTvSeriesDetail], AddTvWatchlist(testTvSeriesDetail).props);
    expect(
        [testTvSeriesDetail], RemoveTvWatchlist(testTvSeriesDetail).props);
    expect([1], LoadTvWatchlistStatus(1).props);
  });
}