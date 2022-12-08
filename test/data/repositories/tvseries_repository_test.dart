import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_detail_model.dart';
import 'package:ditonton/data/models/tvseries/tvseries_model.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late TvRepositoryImpl tvSeriesRepository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;  

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();    
    tvSeriesRepository = TvRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        tvLocalDataSource: mockTvSeriesLocalDataSource,
    );
  });

  final tvSeriesModel = TvSeriesModel(
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

  final tvSeriesModelList = <TvSeriesModel>[tvSeriesModel];
  final tvList = <TvSeries>[tvSeries];


  group('Get Movie Recommendations', () {
    final tSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data when the call is successful', () async {
      /// arrange
      when(mockRemoteDataSource.getTvRecommendations(tId)).thenAnswer((_) async => tSeriesList);
      /// act
      final result = await tvSeriesRepository.getTvSeriesRecommendations(tId);
      /// assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerFailure(''));
      // act
      final result = await tvSeriesRepository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed connect to network'));
      // act
      final result = await tvSeriesRepository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect( 
        result, 
        Left(ConnectionFailure('Failed connect to network'))
      );
    });


  });

  group('Popular Tv Series', (){
    test('should return list tv series when call to data source is success', () async{
      when(mockRemoteDataSource.getPopularTvSeries()).thenAnswer((_) async => tvSeriesModelList);
      final result = await tvSeriesRepository.getPopularTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getPopularTvSeries()).thenThrow(ServerException());
      final result = await tvSeriesRepository.getPopularTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await tvSeriesRepository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('Top Rated Tv Series', (){
    test('should return list tv series when call to data source is success', () async{
      when(mockRemoteDataSource.getTopRatedTvSeries()).thenAnswer((_) async => tvSeriesModelList);
      final result = await tvSeriesRepository.getTopRatedTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getTopRatedTvSeries()).thenThrow(ServerException());
      final result = await tvSeriesRepository.getTopRatedTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await tvSeriesRepository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('Airing Today Tv Series', (){
    test('should return list tv series when call to data source is success', () async{
      when(mockRemoteDataSource.getAiringTodayTvSeries()).thenAnswer((_) async => tvSeriesModelList);
      final result = await tvSeriesRepository.getAiringTodayTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getAiringTodayTvSeries()).thenThrow(ServerException());
      final result = await tvSeriesRepository.getAiringTodayTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await tvSeriesRepository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('On The Air Tv Series', (){
    test('should return list tv series  when call to data source is success', () async{
      when(mockRemoteDataSource.getOnTheAirTvSeries()).thenAnswer((_) async => tvSeriesModelList);
      final result = await tvSeriesRepository.getOnTheAirTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.getOnTheAirTvSeries()).thenThrow(ServerException());
      final result = await tvSeriesRepository.getOnTheAirTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTvSeries())
          .thenThrow(const SocketException('Failed to connect the network'));
      // act
      final result = await tvSeriesRepository.getOnTheAirTvSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTvSeries());
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });
  });

  group('Search Tv Series', (){
    final tQuery = 'pasion';

    test('should return list tv series  when call to data source is success', () async{
      when(mockRemoteDataSource.searchTvSeries(tQuery)).thenAnswer((_) async => tvSeriesModelList);      
      final result = await tvSeriesRepository.searchTvSeries(tQuery);      
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      when(mockRemoteDataSource.searchTvSeries(tQuery)).thenThrow(ServerException());
      final result = await tvSeriesRepository.searchTvSeries(tQuery);
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {      
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect the network'));
      final result = await tvSeriesRepository.searchTvSeries(tQuery);
      verify(mockRemoteDataSource.searchTvSeries(tQuery));
      expect( 
        result, 
        Left(ConnectionFailure('Failed to connect the network'))
      );
    });

  });

  group('Save watchlist Tv Series', (){

    test('should return success message when saving successful', () async{
      when(mockTvSeriesLocalDataSource.insertWatchlistTv(testTvSeriesTable)).thenAnswer((_) async => "Added to watchlist");
      final result = await tvSeriesRepository.saveWatchlistTvSeries(testTvSeriesDetail);
      expect(result, Right('Added to watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async{
      when(mockTvSeriesLocalDataSource.insertWatchlistTv(testTvSeriesTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await tvSeriesRepository.saveWatchlistTvSeries(testTvSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist Tv Series', (){

    test('should return success message when remove successful', () async{
      when(mockTvSeriesLocalDataSource.removeWatchlistTv(testTvSeriesTable)).thenAnswer((_) async => "Removed from watchlist");
      final result = await tvSeriesRepository.removeWatchlistTvSeries(testTvSeriesDetail);
      expect(result, Right('Removed from watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async{
      when(mockTvSeriesLocalDataSource.removeWatchlistTv(testTvSeriesTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await tvSeriesRepository.removeWatchlistTvSeries(testTvSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status Tv Series', (){
    test('should return watch status weather data is found', () async{
      final tId = 1;
      when(mockTvSeriesLocalDataSource.getTvSeriesById(tId)).thenAnswer((_) async => null);
      final result = await tvSeriesRepository.isAddedToWatchlistTvSeries(tId);
      expect(result, false);
    });
  });

  group('Get watchlist Tv Series', (){
    test('should return list of movies', () async{
      when(mockTvSeriesLocalDataSource.getWatchlistTvSeries()).thenAnswer((_) async => [testTvSeriesTable]);
      final result = await tvSeriesRepository.getWatchlistTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tvResponse = TvDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',      
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: '',
      id: 1,      
      originalLanguage: '',      
      overview: 'overview',
      popularity: 0.0,
      posterPath: 'posterPath',            
      status: '',
      tagline: '',            
      voteAverage: 0,
      voteCount: 0, 
      firstAirDate: 'firstAirDate', 
      inProduction: false, 
      lastAirDate: 'lastAirDate', 
      name: 'name', 
      nextEpisodeToAir: null, 
      numberOfEpisodes: 0, 
      numberOfSeasons: 0, 
      originalName: '', 
      seasons: [], 
      type: '',

      
    );

    test(
        'should return tv series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tvResponse);
      // act
      final result = await tvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await tvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed connect to network'));
      // act
      final result = await tvSeriesRepository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed connect to network'))));
    });
  });

}