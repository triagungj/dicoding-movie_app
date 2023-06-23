import 'package:dependencies/sqflite_common_ffi/sqflite_common_ffi.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() async {
  late MockDatabaseHelper mockDatabaseHelper;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
    mockDatabaseHelper = MockDatabaseHelper();
  });

  group('Initialization Database', () {
    test('should return database type', () async {
      // arrange
      when(mockDatabaseHelper.database).thenAnswer(
        (_) async => DatabaseHelper().database,
      );
      // act
      final databaseTest = await mockDatabaseHelper.database;

      // assert
      expect(databaseTest, isA<Database>());
    });
  });

  group('Insert data into database', () {
    test(
      'should return success status if data successfully added',
      () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlistMovie(testMovieTable))
            .thenAnswer(
          (_) async => 1,
        );
        // act
        final status = await mockDatabaseHelper.insertWatchlistMovie(
          testMovieTable,
        );

        // assert
        expect(status, 1);
      },
    );
  });
}
