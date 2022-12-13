import 'package:ditonton/presentation/bloc/movie/search_movie_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when the props are the same as the input do a check!', () {
    expect(['Hail'], MovieQueryChanged('Hail').props);
  });
}
