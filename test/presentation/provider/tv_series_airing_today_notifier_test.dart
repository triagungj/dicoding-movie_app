import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:ditonton/presentation/provider/tv_series_airing_today_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvAiringToday,
])
void main() {
  late MockGetTvAiringToday mockGetTvAiringToday;
  late TvSeriesAiringTodayNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvAiringToday = MockGetTvAiringToday();
    notifier = TvSeriesAiringTodayNotifier(mockGetTvAiringToday)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Tv Series Airing Today', () {
    test(
      'should change state when usecase has been executed',
      () async {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        // act
        unawaited(notifier.fetchAiringTodayTv());

        // assert
        expect(notifier.state, RequestState.loading);
        listenerCallCount = 1;
      },
    );

    test(
      'should change tv series airing today when success get data',
      () async {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        await notifier.fetchAiringTodayTv();

        // assert
        expect(notifier.listAiringTodayTv, [testTvSeries]);
        expect(notifier.state, RequestState.loaded);
        expect(listenerCallCount, 2);
      },
    );
    test(
      'should return ServerFailure when get data failed',
      () async {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (realInvocation) async => const Left(
            ServerFailure('Failed get data'),
          ),
        );

        // act
        await notifier.fetchAiringTodayTv();

        // assert
        expect(notifier.state, RequestState.error);
        expect(notifier.message, 'Failed get data');
        expect(listenerCallCount, 2);
      },
    );
  });
}
