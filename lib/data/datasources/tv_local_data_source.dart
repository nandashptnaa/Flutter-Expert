

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper_tv.dart';
import 'package:ditonton/data/models/tvseries/tvseries_table.dart';

abstract class TvLocalDataSource{
  Future<String> insertWatchlistTv(TvSeriesTable tvTable);
  Future<String> removeWatchlistTv(TvSeriesTable tvTable);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}


class TvLocalDataSourceImpl implements TvLocalDataSource{
  final DatabaseHelperTvSeries databaseHelperTv;

  TvLocalDataSourceImpl({required this.databaseHelperTv});

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async{
    // TODO: implement getTvSeriesById
    final result = await databaseHelperTv.getTvSeriesById(id);
    if(result != null){
      return TvSeriesTable.fromMap(result);
    }else{
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async{
    // TODO: implement getWatchlistTv
    final result = await databaseHelperTv.getWatchlistTvSeries();
    return result.map((e) => TvSeriesTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlistTv(TvSeriesTable tvTable) async {
    // TODO: implement insertWatchlistTv
    try{
      await databaseHelperTv.insertWatchlistTv(tvTable);
      return 'Added to watchlist';
    }catch (e){
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvSeriesTable tvTable) async{
    // TODO: implement removeWatchlistTv
    try{
      await databaseHelperTv.removeWatchList(tvTable);
      return 'Remove from watchlist';
    }catch(e){
      throw DatabaseException(e.toString());
    }
  }

}

