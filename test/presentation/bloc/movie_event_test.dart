import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when the props are the same as the input do a check!', () {
    expect([], FetchMoviesData().props);
    expect([1], FetchMovieById(1).props);
  });
}
