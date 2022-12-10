import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc detailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatusMovie mockGetWatchlistStatus;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchlistStatus = MockGetWatchListStatusMovie();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    detailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getWatchListMovieStatus: mockGetWatchlistStatus, 
      removeWatchlistMovie: mockRemoveWatchlist, 
      saveWatchlistMovie: mockSaveWatchlist,
    );
  });

  const tId = 1;

  group('Get Movie Detail Movie', () {
    test('initial state should be empty', () {
      expect(detailBloc.state.movieDetailState, RequestState.Empty);
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async =>  Right(testMovieDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add( FetchMovieDetailById(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(movieDetailState: RequestState.Loading),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit when get top rated movie is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add( FetchMovieDetailById(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(movieDetailState: RequestState.Loading),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Error,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Watchlist Movie Status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Get Watchlist Movie Status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add( WatchlistMovieStatus(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetail: testMovieDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should execute save watchlist movie when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async =>  Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add( AddMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMovie: 'Success'),
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
            watchlistMovie: 'Success'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should execute remove watchlist movie when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async =>  Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add( RemoveMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMovie: 'Removed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should update watchlist message when remove watchlist movie failed',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add( RemoveMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMovie: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should update watchlist message when add watchlist movie failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add( AddMovieWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMovie: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
  });
}
