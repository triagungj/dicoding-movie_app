import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/presentation/provider/tv_series_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvPopular,
])
void main() {
  late MockGetTvPopular mockGetTvPopular;
  late TvSeriesPopularNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvPopular = MockGetTvPopular();
    notifier = TvSeriesPopularNotifier(
      getTvPopular: mockGetTvPopular,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Popular Tv Series Notifier', () {
    test(
      'should change state loading when usecase is called',
      () async {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        // act
        unawaited(notifier.fetchPopularTvSeries());

        // assert
        expect(notifier.tvSeriesPopularState, RequestState.loading);
        expect(listenerCallCount, 1);
      },
    );
    test(
      'should change tv series data when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        await notifier.fetchPopularTvSeries();

        // assert
        expect(notifier.listTvSeriesPopular, [testTvSeries]);
        expect(notifier.tvSeriesPopularState, RequestState.loaded);
        expect(listenerCallCount, 2);
      },
    );
    test(
      'should return error when get data is failed',
      () async {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );

        // act
        await notifier.fetchPopularTvSeries();

        // assert
        expect(notifier.message, 'Server Failure');
        expect(notifier.tvSeriesPopularState, RequestState.error);
        expect(listenerCallCount, 2);
      },
    );
  });
}
