import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tvSeriesModel = TvSeriesModel(
    id: 123,
    name: 'test',
    overview: 'lorem ipsum',
    firstAirDate: '2023-01-01',
    posterPath: '/2378u2983239.jpg',
    backdropPath: '/2378u2983239.jpg',
    genreIds: [12, 15],
    originCountry: ['PH'],
    originalLanguage: 'en',
    originalName: 'Forever',
    popularity: 23894.2,
    voteAverage: 6.12,
    voteCount: 38,
  );
  const tvSeries = TvSeries(
    id: 123,
    name: 'test',
    overview: 'lorem ipsum',
    firstAirDate: '2023-01-01',
    posterPath: '/2378u2983239.jpg',
    backdropPath: '/2378u2983239.jpg',
    genreIds: [12, 15],
    originCountry: ['PH'],
    originalLanguage: 'en',
    originalName: 'Forever',
    popularity: 23894.2,
    voteAverage: 6.12,
    voteCount: 38,
  );
  final tvSeriesModelList = [tvSeriesModel];
  final tvSeriesList = [tvSeries];

  group('Airing Today Tv Series', () {
    test(
      '''should return remote data when the call to remote data source is successful''',
      () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvSeries()).thenAnswer(
          (_) async => tvSeriesModelList,
        );

        // act
        final result = await repository.getAiringTodayTvSeries();

        // assert
        verify(mockRemoteDataSource.getAiringTodayTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tvSeriesList);
      },
    );
    test(
        '''should return server failure when the call to remote data source is unsuccessful''',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(result, equals(const Left<Failure, dynamic>(ServerFailure(''))));
    });

    test(
        '''should return connection failure when the device is not connected to internet''',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Popular TV Series', () {
    test(
      '''should return remote data when the call to remote data source is successful''',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvSeries()).thenAnswer(
          (_) async => tvSeriesModelList,
        );

        // act
        final result = await repository.getPopularTvSeries();

        // assert
        verify(mockRemoteDataSource.getPopularTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tvSeriesList);
      },
    );
    test(
        '''should return server failure when the call to remote data source is unsuccessful''',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(result, equals(const Left<Failure, dynamic>(ServerFailure(''))));
    });

    test(
        '''should return connection failure when the device is not connected to internet''',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Top rated Tv Series', () {
    test(
      '''should return remote data when the call to remote data source is successful''',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvSeries()).thenAnswer(
          (_) async => tvSeriesModelList,
        );

        // act
        final result = await repository.getTopRatedTvSeries();

        // assert
        verify(mockRemoteDataSource.getTopRatedTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tvSeriesList);
      },
    );
    test(
        '''should return server failure when the call to remote data source is unsuccessful''',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(result, equals(const Left<Failure, dynamic>(ServerFailure(''))));
    });

    test(
        '''should return connection failure when the device is not connected to internet''',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Tv Series detail', () {
    const tvId = 1;

    test(
      '''should return remote data when the call to remote data source is successful''',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvSeriesDetail(tvId)).thenAnswer(
          (_) async => testTvSeriesDetailModel,
        );

        // act
        final result = await repository.getTvSeriesDetail(tvId);

        // assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tvId));

        expect(
          result,
          equals(const Right<dynamic, TvSeriesDetail>(testTvSeriesDetail)),
        );
      },
    );
    test(
        '''should return server failure when the call to remote data source is unsuccessful''',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tvId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tvId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tvId));
      expect(result, equals(const Left<Failure, dynamic>(ServerFailure(''))));
    });

    test(
        '''should return connection failure when the device is not connected to internet''',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tvId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tvId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tvId));
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Tv Series recommendations', () {
    const tvId = 1;
    test(
      '''should return remote data when the call to remote data source is successful''',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvSeriesRecommendations(tvId)).thenAnswer(
          (_) async => tvSeriesModelList,
        );

        // act
        final result = await repository.getTvSeriesRecommendations(tvId);

        // assert
        verify(mockRemoteDataSource.getTvSeriesRecommendations(tvId));

        final resultList = result.getOrElse(() => []);
        expect(resultList, tvSeriesList);
      },
    );
    test(
        '''should return server failure when the call to remote data source is unsuccessful''',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tvId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tvId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tvId));
      expect(result, equals(const Left<Failure, dynamic>(ServerFailure(''))));
    });

    test(
        '''should return connection failure when the device is not connected to internet''',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tvId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tvId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tvId));
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Search Tv Series', () {
    const query = 'forever';
    test(
      '''should return remote data when the call to remote data source is successful''',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvSeries(query)).thenAnswer(
          (_) async => tvSeriesModelList,
        );

        // act
        final result = await repository.searchTvSeries(query);

        // assert
        verify(mockRemoteDataSource.searchTvSeries(query));

        final resultList = result.getOrElse(() => []);
        expect(resultList, tvSeriesList);
      },
    );
    test(
        '''should return server failure when the call to remote data source is unsuccessful''',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(query))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(query);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(query));
      expect(result, equals(const Left<Failure, dynamic>(ServerFailure(''))));
    });

    test(
        '''should return connection failure when the device is not connected to internet''',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(query))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(query);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(query));
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, const Right<dynamic, String>('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(
        result,
        const Left<Failure, dynamic>(
          DatabaseFailure('Failed to add watchlist'),
        ),
      );
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, const Right<dynamic, String>('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(
        result,
        const Left<Failure, dynamic>(
          DatabaseFailure('Failed to remove watchlist'),
        ),
      );
    });
  });

  group('Is watchlist added', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Watchlist TV Series', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
    test('should return failure if list is fail to loaded', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenThrow(DatabaseException('Error'));

      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      verify(mockLocalDataSource.getWatchlistTvSeries());
      expect(
        result,
        equals(const Left<Failure, dynamic>(DatabaseFailure('Error'))),
      );
    });
  });
}
