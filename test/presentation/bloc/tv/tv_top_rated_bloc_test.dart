import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late TopRatedTvseriesBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    topRatedBloc = TopRatedTvseriesBloc(mockGetTopRatedTvseries);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyTvData());
  });

  blocTest<TopRatedTvseriesBloc, TvSeriesState>(
    'Should emit when data tv series is gotten successfully',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      LoadedTvData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetTopRatedTvseries.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetTopRatedTvseries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvseries.execute());
    },
  );
}
