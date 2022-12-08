import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries/tvseries.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';
import 'package:dartz/dartz.dart';

class SearchTvSeries{
  final TvRepository repository;
  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query){
    return repository.searchTvSeries(query);
  }
}