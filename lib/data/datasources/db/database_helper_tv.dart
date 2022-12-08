import 'package:ditonton/data/models/tvseries/tvseries_table.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelperTvSeries{
  static DatabaseHelperTvSeries? _databaseHelperTv;
  DatabaseHelperTvSeries._instance(){
    _databaseHelperTv = this;
  }

  factory DatabaseHelperTvSeries() => _databaseHelperTv ?? DatabaseHelperTvSeries._instance();

  static Database? _database;
  Future<Database?> get database async{
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlistTv';  

  Future<Database> _initDb() async{
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontontv.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int version) async{
    await db.execute('''
        CREATE TABLE $_tblWatchlist(
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
        );
    ''');
  }

  Future<int> insertWatchlistTv(TvSeriesTable tvTable) async{
    final db = await database;
    return await db!.insert(_tblWatchlist, tvTable.toJson());
  }

  Future<int> removeWatchList(TvSeriesTable tvTable) async{
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async{
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );
    if(results.isNotEmpty){
      return results.first;
    }else{
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}