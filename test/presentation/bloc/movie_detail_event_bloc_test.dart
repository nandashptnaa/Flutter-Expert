import 'package:ditonton/presentation/bloc/movie/movie_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('when the props are the same as the input do a check!', () {
    expect([1], FetchMovieDetailById(1).props);
    expect([testMovieDetail], AddMovieWatchlist(testMovieDetail).props);
    expect([testMovieDetail], RemoveMovieWatchlist(testMovieDetail).props);
    expect([1], WatchlistMovieStatus(1).props);
  });
}