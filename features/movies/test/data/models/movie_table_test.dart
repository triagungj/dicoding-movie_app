import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return map', () {
    final result = testMovieTable.toJson();

    expect(result, isA<Map<String, dynamic>>());
  });
}
