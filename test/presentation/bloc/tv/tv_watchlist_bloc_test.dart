import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late MockGetWatchlistTvseries mockGetWatchlistTvseries;
  late WatchlistTvseriesBloc watchlistBloc;

  setUp(() {
    mockGetWatchlistTvseries = MockGetWatchlistTvseries();
    watchlistBloc = WatchlistTvseriesBloc(mockGetWatchlistTvseries);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, EmptyTvData());
  });

  blocTest<WatchlistTvseriesBloc, TvSeriesState>(
    'Should emit when data tv series is gotten successfully',
    build: () {
      when(mockGetWatchlistTvseries.execute())
          .thenAnswer((_) async => Right([testWatchlistTvSeries]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      TvHasData([testWatchlistTvSeries]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTvseries.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, TvSeriesState>(
    'Should emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTvseries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvseries.execute());
    },
  );
}
