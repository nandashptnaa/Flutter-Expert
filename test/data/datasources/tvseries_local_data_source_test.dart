import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelperTvSeries mockDatabaseHelperTvSeries;

  setUp((){
    mockDatabaseHelperTvSeries = MockDatabaseHelperTvSeries();
    dataSource = TvLocalDataSourceImpl(databaseHelperTv: mockDatabaseHelperTvSeries);
  });

  group('Save watchlist tv series', (){
    test('should return success message wen insert to database is successful', () async{
      /// arrange
      when(mockDatabaseHelperTvSeries.insertWatchlistTv(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      /// act
      final result = await dataSource.insertWatchlistTv(testTvSeriesTable);
      /// assert
      expect(result, 'Added to watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelperTvSeries.insertWatchlistTv(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTv(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTvSeries.removeWatchList(testTvSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTv(testTvSeriesTable);
      // assert
      expect(result, 'Remove from watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTvSeries.removeWatchList(testTvSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTv(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTvSeries.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesMap);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTvSeries.getTvSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelperTvSeries.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });
}