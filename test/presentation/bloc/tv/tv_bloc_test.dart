import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tvseries/get_airing_today_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_event.dart';
import 'package:ditonton/presentation/bloc/tvseries/tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries, GetOnTheAirTvSeries])
void main() {
  late MockGetAiringTvseries mockGetAiringTvseries;
  late MockGetOnTheAirTvseries mockGetOnTheAirTvseries;
  late TvSeriesAiringTodayBloc tvSeriesAiringTodayBloc;
  late TvSeriesOnTheAirBloc tvSeriesOnTheAirBloc;

  setUp(
    () {
      mockGetAiringTvseries = MockGetAiringTvseries();
      mockGetOnTheAirTvseries = MockGetOnTheAirTvseries();
      tvSeriesAiringTodayBloc = TvSeriesAiringTodayBloc(mockGetAiringTvseries);
      tvSeriesOnTheAirBloc = TvSeriesOnTheAirBloc(mockGetOnTheAirTvseries);
    },
  );

  test('initial state should be empty', () {
    expect(tvSeriesAiringTodayBloc.state, EmptyTvData());
  });

  blocTest<TvSeriesAiringTodayBloc, TvSeriesState>(
    'Should emit when data is gotten successfully',
    build: () {
      when(mockGetAiringTvseries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesAiringTodayBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      TvHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTvseries.execute());
    },
  );

  blocTest<TvSeriesAiringTodayBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetAiringTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesAiringTodayBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTvseries.execute());
    },
  );

  blocTest<TvSeriesAiringTodayBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetAiringTvseries.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return tvSeriesAiringTodayBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTvseries.execute());
    },
  );

  blocTest<TvSeriesAiringTodayBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetAiringTvseries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return tvSeriesAiringTodayBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTvseries.execute());
    },
  );

  ///
  test('initial state should be empty', () {
    expect(tvSeriesOnTheAirBloc.state, EmptyTvData());
  });

  blocTest<TvSeriesOnTheAirBloc, TvSeriesState>(
    'Should emit when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvseries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return tvSeriesOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      TvHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvseries.execute());
    },
  );

  blocTest<TvSeriesOnTheAirBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvseries.execute());
    },
  );

  blocTest<TvSeriesOnTheAirBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvseries.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return tvSeriesOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTvseries.execute());
    },
  );

  blocTest<TvSeriesOnTheAirBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetOnTheAirTvseries.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return tvSeriesOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesData()),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Database Failure'),
    ],
    verify: (bloc) {
      verifyNever(mockGetAiringTvseries.execute());
    },
  );
}
