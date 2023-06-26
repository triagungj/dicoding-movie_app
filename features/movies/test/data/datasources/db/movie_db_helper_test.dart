import 'package:dependencies/sqflite_common_ffi/sqflite_common_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/data/datasources/db/movies_db_helper.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() async {
  late MockMoviesDbHelper mockDatabaseHelper;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
    mockDatabaseHelper = MockMoviesDbHelper();
  });

  group('Initialization Database', () {
    test('should return database type', () async {
      // arrange
      when(mockDatabaseHelper.database).thenAnswer(
        (_) async => MoviesDbHelper().database,
      );
      // act
      final databaseTest = await mockDatabaseHelper.database;

      // assert
      expect(databaseTest, isA<Database>());
    });
    test('should run oncreate function', () async {
      final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      when(mockDatabaseHelper.onCreate(db, 1))
          .thenAnswer((realInvocation) => MoviesDbHelper().onCreate(db, 1));
      when(mockDatabaseHelper.database)
          .thenAnswer((realInvocation) async => db);

      await mockDatabaseHelper.onCreate(db, 1);
      verify(mockDatabaseHelper.onCreate(db, 1));

      expect(await mockDatabaseHelper.database, isA<Database>());
    });
  });

  group('Test TV Series', () {
    test(
      'should return success status when insert to database successfully',
      () async {
        // arrange
        final moviesDbHelper = MoviesDbHelper();
        await moviesDbHelper.removeWatchlistMovie(testMovieTable);
        when(mockDatabaseHelper.insertWatchlistMovie(testMovieTable))
            .thenAnswer(
          (realInvocation) async =>
              moviesDbHelper.insertWatchlistMovie(testMovieTable),
        );
        // act
        final status = await mockDatabaseHelper.insertWatchlistMovie(
          testMovieTable,
        );
        // assert
        expect(status, isA<int>());
      },
    );
    test(
      'should return success status when remove from database successfully',
      () async {
        // arrange
        final moviesDbHelper = MoviesDbHelper();
        when(mockDatabaseHelper.removeWatchlistMovie(testMovieTable))
            .thenAnswer(
          (realInvocation) async =>
              moviesDbHelper.removeWatchlistMovie(testMovieTable),
        );
        // act
        final status = await mockDatabaseHelper.removeWatchlistMovie(
          testMovieTable,
        );
        // assert
        expect(status, isA<int>());
      },
    );

    test(
      'should return tv series detail when successfully get tv series by id',
      () async {
        // arrange
        final moviesDbHelper = MoviesDbHelper();
        await moviesDbHelper.insertWatchlistMovie(testMovieTable);
        when(mockDatabaseHelper.getMovieById(testMovieTable.id)).thenAnswer(
          (realInvocation) async =>
              moviesDbHelper.getMovieById(testMovieTable.id),
        );
        // act
        final status = await mockDatabaseHelper.getMovieById(
          testMovieTable.id,
        );
        // assert
        expect(status, isA<Map<String, dynamic>>());
      },
    );

    test(
      'should return list tv series when successfully get watchlist tv series',
      () async {
        // arrange
        final moviesDbHelper = MoviesDbHelper();
        when(mockDatabaseHelper.getWatchlistMovies()).thenAnswer(
          (realInvocation) async => moviesDbHelper.getWatchlistMovies(),
        );
        // act
        final status = await mockDatabaseHelper.getWatchlistMovies();
        // assert
        expect(status, isA<List<Map<String, dynamic>>>());
      },
    );
  });
}
