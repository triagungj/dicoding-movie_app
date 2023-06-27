import 'dart:convert';
import 'dart:io';

import 'package:core/exception.dart';
import 'package:core/json_reader.dart';
import 'package:dependencies/http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/models/tv_series_detail_response.dart';
import 'package:tv_series/data/models/tv_series_response.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvSeriesRemoteDataSourceImpl(mockIOClient);
  });

  group('get Airing Today Tv Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      jsonDecode(readJson('dummy_data/tv_airing_today.json'))
          as Map<String, dynamic>,
    ).tvSeriesList;

    test(
      'should return list of Tv Series Model when the response code is 200',
      () async {
        // arrange
        when(
          mockIOClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_airing_today.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getAiringTodayTvSeries();

        // assert
        expect(result, tTvSeriesList);
      },
    );

    test(
      'should throw a ServerExeption when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockIOClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getAiringTodayTvSeries();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get pupular Tv Series', () {
    final listPopularTv = TvSeriesResponse.fromJson(
      jsonDecode(readJson('dummy_data/tv_series_popular.json'))
          as Map<String, dynamic>,
    ).tvSeriesList;
    test(
      'should return list of popular TV Series Model when status code is 200',
      () async {
        // arrange
        when(
          mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_popular.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );
        // act
        final result = await dataSource.getPopularTvSeries();

        // assert
        expect(result, listPopularTv);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
            .thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        // act
        final call = dataSource.getPopularTvSeries();

        // assert
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });
  group('get top rated Tv Series', () {
    final listTopRated = TvSeriesResponse.fromJson(
      jsonDecode(readJson('dummy_data/tv_top_rated.json'))
          as Map<String, dynamic>,
    ).tvSeriesList;

    test(
      'should return a list of Top rated tv series',
      () async {
        // arrange
        when(
          mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_top_rated.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final result = await dataSource.getTopRatedTvSeries();

        // assert
        expect(result, listTopRated);
      },
    );

    test(
      'should throw a ServerException when status code is 404 or other',
      () {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
            .thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        // act
        final call = dataSource.getTopRatedTvSeries();

        // assert
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });
  group('get Tv Series detail', () {
    const tvId = 1;
    final tvDetail = TvSeriesDetailResponse.fromJson(
      jsonDecode(readJson('dummy_data/tv_series_detail.json'))
          as Map<String, dynamic>,
    );

    test(
      'should return a Tv Series Detail',
      () async {
        // arrange
        when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tvId?$apiKey')))
            .thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_detail.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        // act
        final result = await dataSource.getTvSeriesDetail(tvId);

        // assert
        expect(result, tvDetail);
      },
    );

    test(
      'should throw a ServerException when status code is 404 or other',
      () async {
        // arrange
        when(
          mockIOClient.get(Uri.parse('$baseUrl/tv/$tvId?$apiKey')),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.getTvSeriesDetail(tvId);

        // assert
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });
  group(
    'get Tv Series Recommendations',
    () {
      const tvId = 1;
      final listRecommendations = TvSeriesResponse.fromJson(
        jsonDecode(readJson('dummy_data/tv_recommendations.json'))
            as Map<String, dynamic>,
      ).tvSeriesList;

      test(
        'should return a list recommendations Tv Series',
        () async {
          // arrange
          when(
            mockIOClient.get(
              Uri.parse('$baseUrl/tv/$tvId/recommendations?$apiKey'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'),
              200,
              headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              },
            ),
          );
          // act
          final result = await dataSource.getTvSeriesRecommendations(tvId);

          // assert
          expect(result, listRecommendations);
        },
      );

      test(
        'should throw a ServerException when status code is 404 or other',
        () async {
          // arrange
          when(
            mockIOClient.get(
              Uri.parse('$baseUrl/tv/$tvId/recommendations?$apiKey'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'Not Found',
              404,
            ),
          );

          // act
          final call = dataSource.getTvSeriesRecommendations(tvId);

          // assert
          expect(call, throwsA(isA<ServerException>()));
        },
      );
    },
  );
  group('search tv series', () {
    const query = 'forever';
    final tvSeriesSearched = TvSeriesResponse.fromJson(
      jsonDecode(readJson('dummy_data/tv_series_search.json'))
          as Map<String, dynamic>,
    ).tvSeriesList;

    test('should return a list of searched tv series', () async {
      // arrange
      when(
        mockIOClient.get(Uri.parse('$baseUrl/search/tv?query=$query&$apiKey')),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_series_search.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      // act
      final result = await dataSource.searchTvSeries(query);
      // assert
      expect(result, tvSeriesSearched);
    });

    test(
      'should throw a ServerExeption when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?query=$query&$apiKey')),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        // act
        final call = dataSource.searchTvSeries(query);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
