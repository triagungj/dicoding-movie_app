import 'dart:async';

import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTv,
])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTv();
    notifier = WatchlistTvSeriesNotifier(mockGetWatchlistTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Tv Series Watchlist', () {
    test(
      'should change state when usecase has been executed',
      () async {
        // arrange
        when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        unawaited(notifier.fetchWatchlistTv());

        // assert
        expect(notifier.state, RequestState.loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return watchlist tv series when get data successful',
      () async {
        // arrange
        when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        await notifier.fetchWatchlistTv();

        // assert
        expect(notifier.state, RequestState.loaded);
        expect(notifier.listWatchlistTv, [testTvSeries]);
        expect(notifier.message, 'Success get data');
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when failed to get data',
      () async {
        // arrange
        when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Failed to get data')),
        );

        // act
        await notifier.fetchWatchlistTv();

        // assert
        expect(notifier.state, RequestState.error);
        expect(notifier.message, 'Failed to get data');
        expect(listenerCallCount, 2);
      },
    );
  });
}
