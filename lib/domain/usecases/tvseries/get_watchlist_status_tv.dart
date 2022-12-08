import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class GetWatchlistStatusTvSeries{
  final TvRepository repository;

  GetWatchlistStatusTvSeries(this.repository);
  Future<bool> execute(int id)async{
    return repository.isAddedToWatchlistTvSeries(id);
  }
}