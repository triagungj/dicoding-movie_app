import 'dart:async';

import 'package:dependencies/sqflite/sqflite.dart';
import 'package:movies/data/models/movie_table.dart';

class MoviesDbHelper {
  factory MoviesDbHelper() => _databaseHelper ?? MoviesDbHelper._instance();
  MoviesDbHelper._instance() {
    _databaseHelper = this;
  }
  static MoviesDbHelper? _databaseHelper;

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDb();
  }

  static const String _tblWatchlistMovie = 'watchlist_movie';

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_movies.db';

    final db =
        await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return db.insert(_tblWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return db.delete(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db.query(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db.query(_tblWatchlistMovie);

    return results;
  }
}
