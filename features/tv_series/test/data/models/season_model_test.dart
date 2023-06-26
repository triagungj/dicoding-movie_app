import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('Test Season Model', () {
    test(
      'should return entity',
      () {
        final result = testTvSeriesSeasonModel.toEntity();

        expect(result, testTvSeriesSeason);
      },
    );

    test(
      'should return props',
      () {
        final result = testTvSeriesSeasonModel.toEntity();

        expect(result.props, testTvSeriesSeasonModel.props);
      },
    );
  });
}
