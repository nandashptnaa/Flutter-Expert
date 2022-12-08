import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTvSeries{
  final TvRepository repository;
  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvDetail){
    return repository.removeWatchlistTvSeries(tvDetail);
  }
}