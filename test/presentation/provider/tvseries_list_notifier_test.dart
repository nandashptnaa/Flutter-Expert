import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_airing_today_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_list_notifier.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries, GetOnTheAirTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvListNotifier provider;
  late MockGetTvSeriesAiringToday mocktvseriesMockGetTvSeriesAiringToday;
  late MockGetTvSeriesOnTheAir mocktvseriesMockGetTvSeriesOnTheAir;
  late MockGetPopularTvSeries mockGetTvMockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGettvseMockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mocktvseriesMockGetTvSeriesAiringToday = MockGetTvSeriesAiringToday();
    mocktvseriesMockGetTvSeriesOnTheAir = MockGetTvSeriesOnTheAir();
    mockGetTvMockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGettvseMockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvListNotifier(      
      getAiringTodayTv: mocktvseriesMockGetTvSeriesAiringToday, 
      getOnTheAirTv: mocktvseriesMockGetTvSeriesOnTheAir, 
      getPopularTv: mockGetTvMockGetPopularTvSeries, 
      getTopRatedTv: mockGettvseMockGetTopRatedTvSeries
      
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tvSeries = TvSeries(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    genreIds: [18],
    id: 11250,
    name: "Pasión de gavilanes",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 3645.173,
    posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
    voteAverage: 7.6,
    voteCount: 1765
  );
  final tvSeriesList = <TvSeries>[tvSeries];

  group('airing today tv series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mocktvseriesMockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      provider.fetchAiringToday();
      // assert
      verify(mocktvseriesMockGetTvSeriesAiringToday.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mocktvseriesMockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      provider.fetchAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mocktvseriesMockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      await provider.fetchAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTv, tvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mocktvseriesMockGetTvSeriesAiringToday.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('on the air tv series', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirTvState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mocktvseriesMockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      provider.fetchOnTheAir();
      // assert
      verify(mocktvseriesMockGetTvSeriesOnTheAir.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mocktvseriesMockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      provider.fetchOnTheAir();
      // assert
      expect(provider.onTheAirTvState, RequestState.Empty);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mocktvseriesMockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      await provider.fetchOnTheAir();
      // assert
      expect(provider.onTheAirTvState, RequestState.Loaded);
      expect(provider.onTheAirTv, tvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mocktvseriesMockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAir();
      // assert
      expect(provider.onTheAirTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvMockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTvMockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTv, tvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvMockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
