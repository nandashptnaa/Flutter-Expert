import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTvSeries{
  final TvRepository repository;
  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvDetail){
    return repository.saveWatchlistTvSeries(tvDetail);
  }
}