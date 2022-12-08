import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetPopularTvSeries{
  final TvRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(){
    return repository.getPopularTvSeries();
  }
}