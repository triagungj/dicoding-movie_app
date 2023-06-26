import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_detail_response.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('Tv series detail response', () {
    test(
      'should return entity',
      () {
        final result = testTvSeriesDetailModel.toEntity();

        expect(result, testTvSeriesDetail);
      },
    );
    test(
      'should return tv series model from map',
      () async {
        const map = {
          'id': 1,
          'adult': true,
          'backdropPath': '/32eu9d2dd.jpg',
          'firstAirDate': '2023-01-01',
          'lastAirDate': '2023-04-01',
          'name': 'Forever',
          'numberOfEpisodes': 12,
          'numberOfSeasons': 2,
          'overview': 'Lorem ipsum',
          'posterPath': '/2837289.jpg',
          'status': 'Ongoing',
          'voteAverage': '9.1',
          'voteCount': 230,
        };
        final result = TvSeriesDetailResponse.fromJson(map);

        expect(result, isA<TvSeriesDetailResponse>());
      },
    );
  });
}
