import 'dart:async';

import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/presentation/provider/tv_series_top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TvSeriesTopRatedNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvTopRated = MockGetTvTopRated();
    notifier = TvSeriesTopRatedNotifier(mockGetTvTopRated)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Tv Series Top Rated', () {
    test(
      'should change state when usecase has been executed',
      () async {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        unawaited(notifier.fetchTopRatedTv());

        // assert
        expect(notifier.state, RequestState.loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return top rated tv series when get data sucessful',
      () async {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        await notifier.fetchTopRatedTv();

        // assert
        expect(notifier.state, RequestState.loaded);
        expect(notifier.listTopRated, [testTvSeries]);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when get data is failed',
      () async {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Failed get data')),
        );

        // act
        await notifier.fetchTopRatedTv();

        // assert
        expect(notifier.message, 'Failed get data');
        expect(notifier.state, RequestState.error);
        expect(listenerCallCount, 2);
      },
    );
  });
}
