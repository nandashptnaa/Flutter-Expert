import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetTvSeriesRecommendations{
  final TvRepository repository;

  GetTvSeriesRecommendations(this.repository);
  Future<Either<Failure, List<TvSeries>>> execute(id){
    return repository.getTvSeriesRecommendations(id);
  }

}