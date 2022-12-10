import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetRecommendationMovie;
  late MovieRecommendationsBloc recomBloc;

  setUp(() {
    mockGetRecommendationMovie = MockGetMovieRecommendations();
    recomBloc = MovieRecommendationsBloc(mockGetRecommendationMovie);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(recomBloc.state, EmptyData());
  });

  blocTest<MovieRecommendationsBloc, MovieListState>(
    'Should emit when data movie is gotten successfully',
    build: () {
      when(mockGetRecommendationMovie.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchMovieById(tId)),
    expect: () => [LoadingData(), MovieListHasData(testMovieList)],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );

  blocTest<MovieRecommendationsBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchMovieById(tId)),
    expect: () => [LoadingData(), ErrorData('Server Failure')],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );

  blocTest<MovieRecommendationsBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId)).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchMovieById(tId)),
    expect: () => [LoadingData(), ErrorData('Database Failure')],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );

  blocTest<MovieRecommendationsBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId)).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(FetchMovieById(tId)),
    expect: () => [LoadingData(), ErrorData('Connection Failure')],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );
}
