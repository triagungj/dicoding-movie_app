import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvSeriesDetailNotifier notifier;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTvDetail = MockGetTvDetail();
      mockGetTvRecommendations = MockGetTvRecommendations();
      mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
      mockSaveWatchlistTv = MockSaveWatchlistTv();
      mockRemoveWatchlistTv = MockRemoveWatchlistTv();
      notifier = TvSeriesDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getWatchlistStatusTv: mockGetWatchlistStatusTv,
        saveWatchlistTv: mockSaveWatchlistTv,
        removeWatchlistTv: mockRemoveWatchlistTv,
      )..addListener(() {
          listenerCallCount += 1;
        });
    },
  );

  const testId = 1;
  final tvSeriesList = <TvSeries>[testTvSeries];

  void arrangeUsecase() {
    when(mockGetTvDetail.execute(testId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));
    when(mockGetTvRecommendations.execute(testId))
        .thenAnswer((_) async => Right(tvSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await notifier.fetchTvSeriesDetail(testId);
      // assert
      verify(mockGetTvDetail.execute(testId));
      verify(mockGetTvRecommendations.execute(testId));
      expect(listenerCallCount, 3);
    });

    test(
      'should change state to Loading when usecase is called',
      () {
        // arrange
        arrangeUsecase();
        // act
        notifier.fetchTvSeriesDetail(testId);
        // assert
        expect(notifier.tvSeriesDetailState, RequestState.loading);
        expect(listenerCallCount, 1);
      },
    );
    test(
      'should change tv series when data gotten succesfully',
      () async {
        // arrange
        arrangeUsecase();
        // act
        await notifier.fetchTvSeriesDetail(testId);
        // assert
        expect(notifier.tvSeriesDetailState, RequestState.loaded);
        expect(notifier.tvSeriesDetail, testTvSeriesDetail);
        expect(listenerCallCount, 3);
      },
    );
    test(
      'should change recommendation tv series when data is gotten successfully',
      () async {
        // arrange
        arrangeUsecase();
        // act
        await notifier.fetchTvSeriesDetail(testId);
        // assert
        expect(notifier.tvSeriesRecommendationsState, RequestState.loaded);
        expect(notifier.tvSeriesRecommendations, tvSeriesList);
        expect(listenerCallCount, 3);
      },
    );
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await notifier.fetchTvSeriesDetail(testId);
      // assert
      verify(mockGetTvRecommendations.execute(testId));
      expect(notifier.tvSeriesRecommendations, tvSeriesList);
    });

    test(
      'should update recommendation state when data is gotten sucessfully',
      () async {
        // arrange
        arrangeUsecase();
        // act
        await notifier.fetchTvSeriesDetail(testId);
        // assert
        expect(notifier.tvSeriesRecommendationsState, RequestState.loaded);
        expect(notifier.tvSeriesRecommendations, tvSeriesList);
      },
    );

    test(
      'should update error message when request is successfully',
      () async {
        // arrange
        when(mockGetTvDetail.execute(testId)).thenAnswer(
          (_) async => const Right(testTvSeriesDetail),
        );
        when(mockGetTvRecommendations.execute(testId)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.fetchTvSeriesDetail(testId);
        // assert
        expect(notifier.tvSeriesRecommendationsState, RequestState.error);
        expect(notifier.message, 'Server Failure');
      },
    );
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTv.execute(testId)).thenAnswer(
        (_) async => true,
      );
      // act
      await notifier.loadWatchlistStatus(testId);
      // assert
      expect(notifier.isAddedToWatchlist, true);
    });
    test(
      'should execute save watchlist when function called',
      () async {
        // arrange
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Added to Watchlist Successful'),
        );
        when(mockGetWatchlistStatusTv.execute(testTvSeriesDetail.id))
            .thenAnswer(
          (_) async => true,
        );
        // act
        await notifier.addWatchlist(testTvSeriesDetail);
        // assert
        verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
        expect(notifier.watchlistMessage, 'Added to Watchlist Successful');
      },
    );
    test(
      'should execute remove watchlist when function called',
      () async {
        // arrange
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Removed'),
        );
        when(mockGetWatchlistStatusTv.execute(testTvSeriesDetail.id))
            .thenAnswer(
          (_) async => false,
        );

        // act
        await notifier.removeWatchlist(testTvSeriesDetail);
        // assert
        verify(mockRemoveWatchlistTv.execute(testTvSeriesDetail));
        expect(notifier.watchlistMessage, 'Removed');
      },
    );
    test(
      'should update watchlist status when add watchlist success',
      () async {
        // arrange
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Success Added to Watchlist'),
        );
        when(mockGetWatchlistStatusTv.execute(testTvSeriesDetail.id))
            .thenAnswer(
          (_) async => true,
        );
        // act
        await notifier.addWatchlist(testTvSeriesDetail);
        // assert
        verify(mockGetWatchlistStatusTv.execute(testTvSeriesDetail.id));
        expect(notifier.isAddedToWatchlist, true);
        expect(notifier.watchlistMessage, 'Success Added to Watchlist');
        expect(listenerCallCount, 1);
      },
    );
    test(
      'should update watchlist message when add watchlist failed',
      () async {
        // arrange
        when(mockSaveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Add to watchlist failed'),
        );
        when(mockGetWatchlistStatusTv.execute(testTvSeriesDetail.id))
            .thenAnswer(
          (realInvocation) async => false,
        );
        // act
        await notifier.addWatchlist(testTvSeriesDetail);

        // assert
        verify(mockSaveWatchlistTv.execute(testTvSeriesDetail));
        expect(notifier.watchlistMessage, 'Add to watchlist failed');
        expect(notifier.isAddedToWatchlist, false);
        expect(listenerCallCount, 1);
      },
    );
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(testId)).thenAnswer(
        (_) async => const Left(ServerFailure('Failure')),
      );
      when(mockGetTvRecommendations.execute(testId)).thenAnswer(
        (realInvocation) async => const Left(ServerFailure('Failure')),
      );
      // act
      await notifier.fetchTvSeriesDetail(testId);

      // assert
      expect(notifier.tvSeriesDetailState, RequestState.error);
      // expect(notifier.tvSeriesRecommendationsState, RequestState.error);
      expect(notifier.message, 'Failure');
      expect(listenerCallCount, 2);
    });
  });
}
