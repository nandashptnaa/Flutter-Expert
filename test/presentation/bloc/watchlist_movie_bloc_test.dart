import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovie;
  late WatchlistMovieBloc watchlistBloc;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockGetWatchlistMovie);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, EmptyData());
  });

  blocTest<WatchlistMovieBloc, MovieListState>(
    'Should emit when data movie is gotten successfully',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      MovieListHasData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute()).thenAnswer(
          (_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );
  
  blocTest<WatchlistMovieBloc, MovieListState>(
    'Should emit when get top rated movie is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute()).thenAnswer(
          (_) async => Left(ConnectionFailure('Connection Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMoviesData()),
    expect: () => [
      LoadingData(),
      ErrorData('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );
}
