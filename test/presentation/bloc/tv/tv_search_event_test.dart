import 'package:ditonton/presentation/bloc/tvseries/search_tv_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when the props are the same as the input do a check!', () {
    expect(['Hail'], OnTvQueryChanged('Hail').props);
  });
}