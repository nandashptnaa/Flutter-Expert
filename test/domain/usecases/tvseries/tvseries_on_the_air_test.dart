import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_on_the_air_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTvSeries(mockTvSeriesRepository);
  });

  final tvSeries = <TvSeries>[];

  group('Get On The Air Tv Series', (){
    test('should get list of Tv Series from the repository', () async {
    // arrange
      when(mockTvSeriesRepository.getOnTheAirTvSeries())
          .thenAnswer((_) async => Right(tvSeries));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tvSeries));
    });
  });

  
}