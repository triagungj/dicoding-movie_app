import 'dart:async';

import 'package:dependencies/sqflite/sqflite.dart';
import 'package:tv_series/data/models/tv_series_table.dart';

class TvSeriesDbHelper {
  factory TvSeriesDbHelper() => _databaseHelper ?? TvSeriesDbHelper._instance();
  TvSeriesDbHelper._instance() {
    _databaseHelper = this;
  }
  static TvSeriesDbHelper? _databaseHelper;

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDb();
  }

  static const String _tblWatchlistTvSeries = 'watchlist_tv_series';

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tv_series.db';

    final db = await openDatabase(databasePath, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvSeries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTvSeries(TvSeriesTable tvSeries) async {
    final db = await database;
    return db.insert(_tblWatchlistTvSeries, tvSeries.toJson());
  }

  Future<int> removeWatchlistTvSeries(TvSeriesTable tvSeries) async {
    final db = await database;
    return db.delete(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db.query(
      _tblWatchlistTvSeries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db.query(_tblWatchlistTvSeries);

    return results;
  }
}
