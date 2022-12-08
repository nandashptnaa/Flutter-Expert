import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_airing_today_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetAiringTodayTvSeries getTvSeriesAiringToday;
  late MockTvSeriesRepository mockTvSeriesRepository;
  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvSeriesAiringToday = GetAiringTodayTvSeries(mockTvSeriesRepository);
  });

  final tvSeries = <TvSeries>[];
  group('Get Airing Today TV Series', (){
    test('should get list of Tv Series from the repository', () async{
      ///arrange
      when(mockTvSeriesRepository.getAiringTodayTvSeries()).thenAnswer((_) async=> Right(tvSeries));
      ///act
      final result = await getTvSeriesAiringToday.execute();
      ///assert
      expect(result, Right(tvSeries));
    });
  });
}