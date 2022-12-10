import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieListBloc moviesBloc;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      moviesBloc = MovieListBloc(mockGetNowPlayingMovies);
    },
  );

  test('initial state should be empty data', () {
    expect(moviesBloc.state, EmptyData());
  });

  blocTest<MovieListBloc, MovieListState>(
    'Should emit when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      const ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
