import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesDetail{
  final TvRepository repository;

  GetTvSeriesDetail(this.repository);
  Future<Either<Failure, TvSeriesDetail>> execute(int id){
    return repository.getTvSeriesDetail(id);
  }
}