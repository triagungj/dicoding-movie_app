import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvAiringToday,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late TvSeriesListNotifier notifier;
  late MockGetTvAiringToday mockGetTvAiringToday;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvAiringToday = MockGetTvAiringToday();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    notifier = TvSeriesListNotifier(
      mockGetTvAiringToday,
      mockGetTvPopular,
      mockGetTvTopRated,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tvSeriesList = <TvSeries>[testTvSeries];

  group('airing today Tv Series', () {
    test('initialState should be Empty', () {
      expect(notifier.airingTodayTvState, equals(RequestState.empty));
    });

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        await notifier.getAiringTodayTv();
        // assert
        verify(mockGetTvAiringToday.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        notifier.getAiringTodayTv();
        // assert
        expect(notifier.airingTodayTvState, RequestState.loading);
      },
    );

    test(
      'should change tv eries when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        await notifier.getAiringTodayTv();
        // assert
        expect(notifier.airingTodayTvState, RequestState.loaded);
        expect(notifier.airingTodayTv, tvSeriesList);
        expect(listenerCallCount, 2);
      },
    );
    test(
      'should return error when data is unsuccessfull',
      () async {
        // arrange
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.getAiringTodayTv();
        // assert
        expect(notifier.airingTodayTvState, RequestState.error);
        expect(notifier.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('Popular Tv Series', () {
    test('initialState should be Empty', () {
      expect(notifier.popularTvState, equals(RequestState.empty));
    });

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        await notifier.getPopularTv();
        // assert
        verify(mockGetTvPopular.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        notifier.getPopularTv();
        // assert
        expect(notifier.popularTvState, RequestState.loading);
      },
    );

    test(
      'should change tv eries when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        await notifier.getPopularTv();
        // assert
        expect(notifier.popularTvState, RequestState.loaded);
        expect(notifier.popularTv, tvSeriesList);
        expect(listenerCallCount, 2);
      },
    );
    test(
      'should return error when data is unsuccessfull',
      () async {
        // arrange
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.getPopularTv();
        // assert
        expect(notifier.popularTvState, RequestState.error);
        expect(notifier.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('Top Rated Tv Series', () {
    test('initialState should be Empty', () {
      expect(notifier.topRatedTvState, equals(RequestState.empty));
    });

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        await notifier.getTopRatedTv();
        // assert
        verify(mockGetTvTopRated.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        notifier.getTopRatedTv();
        // assert
        expect(notifier.topRatedTvState, RequestState.loading);
      },
    );

    test(
      'should change tv eries when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => Right(tvSeriesList),
        );
        // act
        await notifier.getTopRatedTv();
        // assert
        expect(notifier.topRatedTvState, RequestState.loaded);
        expect(notifier.topRatedTv, tvSeriesList);
        expect(listenerCallCount, 2);
      },
    );
    test(
      'should return error when data is unsuccessfull',
      () async {
        // arrange
        when(mockGetTvTopRated.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        // act
        await notifier.getTopRatedTv();
        // assert
        expect(notifier.topRatedTvState, RequestState.error);
        expect(notifier.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });
}
