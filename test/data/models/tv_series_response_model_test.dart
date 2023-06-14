import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: '/aWPhMZ0P2DyfWB7k5NXhGHSZHGC.jpg',
    firstAirDate: '2023-05-08',
    genreIds: [18, 80, 10766],
    id: 209265,
    name: 'Terra e Paixão',
    originCountry: ['BR'],
    originalLanguage: 'pt',
    originalName: 'Terra e Paixão',
    overview: 'lorem lorem',
    popularity: 2985.435,
    posterPath: '/voaKRrYExZNkf1E4FZExU7fTd8w.jpg',
    voteAverage: 6.6,
    voteCount: 5,
  );

  const tTvSeriesResponseModel = TvSeriesResponse(
    tvSeriesList: <TvSeriesModel>[tTvSeriesModel],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final jsonMap = json.decode(
        readJson('dummy_data/tv_airing_today.json'),
      ) as Map<String, dynamic>;
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        'results': [
          {
            'backdrop_path': '/aWPhMZ0P2DyfWB7k5NXhGHSZHGC.jpg',
            'first_air_date': '2023-05-08',
            'genre_ids': [18, 80, 10766],
            'id': 209265,
            'name': 'Terra e Paixão',
            'origin_country': ['BR'],
            'original_language': 'pt',
            'original_name': 'Terra e Paixão',
            'overview': 'lorem lorem',
            'popularity': 2985.435,
            'poster_path': '/voaKRrYExZNkf1E4FZExU7fTd8w.jpg',
            'vote_average': 6.6,
            'vote_count': 5
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
