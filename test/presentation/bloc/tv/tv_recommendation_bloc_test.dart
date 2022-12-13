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
import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late MockGetTvSeriesRecommendations mockGetRecommendationTvseries;
  late RecommendationTvSeriesBloc recomBloc;

  setUp(() {
    mockGetRecommendationTvseries = MockGetTvSeriesRecommendations();
    recomBloc = RecommendationTvSeriesBloc(mockGetRecommendationTvseries);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(recomBloc.state, EmptyTvData());
  });

  blocTest<RecommendationTvSeriesBloc, TvSeriesState>(
    'Should emit when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesById(tId)),
    expect: () => [
      LoadingTvData(),
      TvHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );

  blocTest<RecommendationTvSeriesBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesById(tId)),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );

  blocTest<RecommendationTvSeriesBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId)).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesById(tId)),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );

  blocTest<RecommendationTvSeriesBloc, TvSeriesState>(
    'Should emit when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetRecommendationTvseries.execute(tId)).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchTvSeriesById(tId)),
    expect: () => [
      LoadingTvData(),
      ErrorTvData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvseries.execute(tId));
    },
  );
}
