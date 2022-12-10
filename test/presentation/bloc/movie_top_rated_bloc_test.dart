import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovie;
  late TopRatedMovieBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMovieBloc(mockGetTopRatedMovie);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyData());
  });

  blocTest<TopRatedMovieBloc, MovieListState>(
    'Should emit when data movie is gotten successfully',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );
  
  blocTest<TopRatedMovieBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );
}
