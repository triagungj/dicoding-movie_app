import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_airing_today.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_airing_today_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvAiringToday,
])
void main() {
  late TvSeriesAiringTodayBloc bloc;
  late MockGetTvAiringToday mockGetTvAiringToday;

  setUp(() {
    mockGetTvAiringToday = MockGetTvAiringToday();

    bloc = TvSeriesAiringTodayBloc(
      getTvAiringToday: mockGetTvAiringToday,
    );
  });

  group('airing today Tv Series', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesAiringTodayInitial());
    });

    blocTest<TvSeriesAiringTodayBloc, TvSeriesAiringTodayState>(
      'emits loading and success when GetTvSeriesAiringTodayEvent added.',
      build: () {
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesAiringTodayEvent()),
      expect: () => <TvSeriesAiringTodayState>[
        TvSeriesAiringTodayLoading(),
        TvSeriesAiringTodaySuccess(const [testTvSeries]),
      ],
    );

    blocTest<TvSeriesAiringTodayBloc, TvSeriesAiringTodayState>(
      'emits loading and failed when GetTvSeriesAiringTodayEvent added.',
      build: () {
        when(mockGetTvAiringToday.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesAiringTodayEvent()),
      expect: () => <TvSeriesAiringTodayState>[
        TvSeriesAiringTodayLoading(),
        TvSeriesAiringTodayFailure('Error'),
      ],
    );

    // test(
    //   'should get data from the usecase',
    //   () async {
    //     // arrange
    //     when(mockGetTvAiringToday.execute()).thenAnswer(
    //       (_) async => Right(tvSeriesList),
    //     );
    //     // act
    //     await notifier.getAiringTodayTv();
    //     // assert
    //     verify(mockGetTvAiringToday.execute());
    //   },
    // );

    // test(
    //   'should change state to Loading when usecase is called',
    //   () {
    //     // arrange
    //     when(mockGetTvAiringToday.execute()).thenAnswer(
    //       (_) async => Right(tvSeriesList),
    //     );
    //     // act
    //     notifier.getAiringTodayTv();
    //     // assert
    //     expect(notifier.airingTodayTvState, RequestState.loading);
    //   },
    // );

    // test(
    //   'should change tv eries when data is gotten successfully',
    //   () async {
    //     // arrange
    //     when(mockGetTvAiringToday.execute()).thenAnswer(
    //       (_) async => Right(tvSeriesList),
    //     );
    //     // act
    //     await notifier.getAiringTodayTv();
    //     // assert
    //     expect(notifier.airingTodayTvState, RequestState.loaded);
    //     expect(notifier.airingTodayTv, tvSeriesList);
    //     expect(listenerCallCount, 2);
    //   },
    // );
    // test(
    //   'should return error when data is unsuccessfull',
    //   () async {
    //     // arrange
    //     when(mockGetTvAiringToday.execute()).thenAnswer(
    //       (_) async => const Left(ServerFailure('Server Failure')),
    //     );
    //     // act
    //     await notifier.getAiringTodayTv();
    //     // assert
    //     expect(notifier.airingTodayTvState, RequestState.error);
    //     expect(notifier.message, 'Server Failure');
    //     expect(listenerCallCount, 2);
    //   },
    // );
  });

  // group('Popular Tv Series', () {
  //   test('initialState should be Empty', () {
  //     expect(notifier.popularTvState, equals(RequestState.empty));
  //   });

  //   test(
  //     'should get data from the usecase',
  //     () async {
  //       // arrange
  //       when(mockGetTvPopular.execute()).thenAnswer(
  //         (_) async => Right(tvSeriesList),
  //       );
  //       // act
  //       await notifier.getPopularTv();
  //       // assert
  //       verify(mockGetTvPopular.execute());
  //     },
  //   );

  //   test(
  //     'should change state to Loading when usecase is called',
  //     () {
  //       // arrange
  //       when(mockGetTvPopular.execute()).thenAnswer(
  //         (_) async => Right(tvSeriesList),
  //       );
  //       // act
  //       notifier.getPopularTv();
  //       // assert
  //       expect(notifier.popularTvState, RequestState.loading);
  //     },
  //   );

  //   test(
  //     'should change tv eries when data is gotten successfully',
  //     () async {
  //       // arrange
  //       when(mockGetTvPopular.execute()).thenAnswer(
  //         (_) async => Right(tvSeriesList),
  //       );
  //       // act
  //       await notifier.getPopularTv();
  //       // assert
  //       expect(notifier.popularTvState, RequestState.loaded);
  //       expect(notifier.popularTv, tvSeriesList);
  //       expect(listenerCallCount, 2);
  //     },
  //   );
  //   test(
  //     'should return error when data is unsuccessfull',
  //     () async {
  //       // arrange
  //       when(mockGetTvPopular.execute()).thenAnswer(
  //         (_) async => const Left(ServerFailure('Server Failure')),
  //       );
  //       // act
  //       await notifier.getPopularTv();
  //       // assert
  //       expect(notifier.popularTvState, RequestState.error);
  //       expect(notifier.message, 'Server Failure');
  //       expect(listenerCallCount, 2);
  //     },
  //   );
  // });

  // group('Top Rated Tv Series', () {
  //   test('initialState should be Empty', () {
  //     expect(notifier.topRatedTvState, equals(RequestState.empty));
  //   });

  //   test(
  //     'should get data from the usecase',
  //     () async {
  //       // arrange
  //       when(mockGetTvTopRated.execute()).thenAnswer(
  //         (_) async => Right(tvSeriesList),
  //       );
  //       // act
  //       await notifier.getTopRatedTv();
  //       // assert
  //       verify(mockGetTvTopRated.execute());
  //     },
  //   );

  //   test(
  //     'should change state to Loading when usecase is called',
  //     () {
  //       // arrange
  //       when(mockGetTvTopRated.execute()).thenAnswer(
  //         (_) async => Right(tvSeriesList),
  //       );
  //       // act
  //       notifier.getTopRatedTv();
  //       // assert
  //       expect(notifier.topRatedTvState, RequestState.loading);
  //     },
  //   );

  //   test(
  //     'should change tv eries when data is gotten successfully',
  //     () async {
  //       // arrange
  //       when(mockGetTvTopRated.execute()).thenAnswer(
  //         (_) async => Right(tvSeriesList),
  //       );
  //       // act
  //       await notifier.getTopRatedTv();
  //       // assert
  //       expect(notifier.topRatedTvState, RequestState.loaded);
  //       expect(notifier.topRatedTv, tvSeriesList);
  //       expect(listenerCallCount, 2);
  //     },
  //   );
  //   test(
  //     'should return error when data is unsuccessfull',
  //     () async {
  //       // arrange
  //       when(mockGetTvTopRated.execute()).thenAnswer(
  //         (_) async => const Left(ServerFailure('Server Failure')),
  //       );
  //       // act
  //       await notifier.getTopRatedTv();
  //       // assert
  //       expect(notifier.topRatedTvState, RequestState.error);
  //       expect(notifier.message, 'Server Failure');
  //       expect(listenerCallCount, 2);
  //     },
  //   );
  // });
}
