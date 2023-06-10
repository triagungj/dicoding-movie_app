import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_search.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([GetTvSearch])
void main() {
  const query = 'query';

  late MockGetTvSearch mockGetTvSearch;
  late TvSeriesSearchNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSearch = MockGetTvSearch();
    notifier = TvSeriesSearchNotifier(mockGetTvSearch)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Tv series search', () {
    test(
      'should change state when usecase has been executed',
      () async {
        // arrange
        when(mockGetTvSearch.execute(query)).thenAnswer(
          (realInvocation) async => const Right([testTvSeries]),
        );

        // act
        unawaited(notifier.fetchSearchedTv(query));

        // assert
        expect(notifier.state, RequestState.loading);
        expect(listenerCallCount, 1);
      },
    );

    test(
      'should return list tv when sucessfully get data',
      () async {
        // arrange
        when(mockGetTvSearch.execute(query)).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );

        // act
        await notifier.fetchSearchedTv(query);

        // assert
        expect(notifier.listTvSeries, [testTvSeries]);
        expect(notifier.state, RequestState.loaded);
        expect(listenerCallCount, 2);
      },
    );
    test(
      'should return ServerFailure when get data is failed',
      () async {
        // arrange
        when(mockGetTvSearch.execute(query)).thenAnswer(
          (_) async => const Left(
            ServerFailure('Failed get data'),
          ),
        );

        // act
        await notifier.fetchSearchedTv(query);

        // assert
        expect(notifier.state, RequestState.error);
        expect(notifier.message, 'Failed get data');
        expect(listenerCallCount, 2);
      },
    );
  });
}
