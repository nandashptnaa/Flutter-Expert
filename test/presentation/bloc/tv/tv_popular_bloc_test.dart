import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tvseries_recommendation.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late MockGetPopularTvseries mockGetPopularTvseries;
  late PopularTvseriesBloc popularBloc;

  setUp(() {
    mockGetPopularTvseries = MockGetPopularTvseries();
    popularBloc = PopularTvseriesBloc(mockGetPopularTvseries);
  });

  test('initial state should be empty', () {
    expect(popularBloc.state, EmptyTvData());
  });

  blocTest<PopularTvseriesBloc, TvSeriesState>(
    'Should emit when data is gotten successfully',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      LoadedTvData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, TvSeriesState>(
    'Should emit when get popular tv is unsuccessful',
    build: () {
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, TvSeriesState>(
    'Should emit when get popular tv is unsuccessful',
    build: () {
      when(mockGetPopularTvseries.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, TvSeriesState>(
    'Should emit when get popular tv is unsuccessful',
    build: () {
      when(mockGetPopularTvseries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(FetchTvseriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvseries.execute());
    },
  );
}
