import 'package:dependencies/sqflite_common_ffi/sqflite_common_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/db/tv_series_db_helper.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() async {
  late MockTvSeriesDbHelper mockDatabaseHelper;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
    mockDatabaseHelper = MockTvSeriesDbHelper();
  });

  group('Initialization Database', () {
    test('should return database type', () async {
      // arrange
      when(mockDatabaseHelper.database).thenAnswer(
        (_) async => TvSeriesDbHelper().database,
      );
      // act
      final databaseTest = await mockDatabaseHelper.database;

      // assert
      expect(databaseTest, isA<Database>());
    });

    test('should run oncreate function', () async {
      final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      when(mockDatabaseHelper.onCreate(db, 1))
          .thenAnswer((realInvocation) => TvSeriesDbHelper().onCreate(db, 1));
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
        final tvSeriesDbHelper = TvSeriesDbHelper();
        await tvSeriesDbHelper.removeWatchlistTvSeries(testTvSeriesTable);
        when(mockDatabaseHelper.insertWatchlistTvSeries(testTvSeriesTable))
            .thenAnswer(
          (realInvocation) async =>
              tvSeriesDbHelper.insertWatchlistTvSeries(testTvSeriesTable),
        );
        // act
        final status = await mockDatabaseHelper.insertWatchlistTvSeries(
          testTvSeriesTable,
        );
        // assert
        expect(status, isA<int>());
      },
    );
    test(
      'should return success status when remove from database successfully',
      () async {
        // arrange
        final tvSeriesDbHelper = TvSeriesDbHelper();
        when(mockDatabaseHelper.removeWatchlistTvSeries(testTvSeriesTable))
            .thenAnswer(
          (realInvocation) async =>
              tvSeriesDbHelper.removeWatchlistTvSeries(testTvSeriesTable),
        );
        // act
        final status = await mockDatabaseHelper.removeWatchlistTvSeries(
          testTvSeriesTable,
        );
        // assert
        expect(status, isA<int>());
      },
    );

    test(
      'should return tv series detail when successfully get tv series by id',
      () async {
        // arrange
        final tvSeriesDbHelper = TvSeriesDbHelper();
        await tvSeriesDbHelper.insertWatchlistTvSeries(testTvSeriesTable);
        when(mockDatabaseHelper.getTvSeriesById(testTvSeriesTable.id))
            .thenAnswer(
          (realInvocation) async =>
              tvSeriesDbHelper.getTvSeriesById(testTvSeriesTable.id),
        );
        // act
        final status = await mockDatabaseHelper.getTvSeriesById(
          testTvSeriesTable.id,
        );
        // assert
        expect(status, isA<Map<String, dynamic>>());
      },
    );

    test(
      'should return list tv series when successfully get watchlist tv series',
      () async {
        // arrange
        final tvSeriesDbHelper = TvSeriesDbHelper();
        when(mockDatabaseHelper.getWatchlistTvSeries()).thenAnswer(
          (realInvocation) async => tvSeriesDbHelper.getWatchlistTvSeries(),
        );
        // act
        final status = await mockDatabaseHelper.getWatchlistTvSeries();
        // assert
        expect(status, isA<List<Map<String, dynamic>>>());
      },
    );
  });
}
