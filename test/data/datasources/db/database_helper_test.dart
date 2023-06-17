import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() async {
  late MockDatabaseHelper mockDatabase;
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory for unit testing calls for SQFlite
    databaseFactory = databaseFactoryFfi;
    mockDatabase = MockDatabaseHelper();
  });

  group('Initialization Database', () {
    test('should return database type', () async {
      // arrange
      when(mockDatabase.database).thenAnswer(
        (_) async => DatabaseHelper().database,
      );

      final databaseTest = await mockDatabase.database;

      // assert
      expect(databaseTest, isA<Database>());
    });
  });
}
