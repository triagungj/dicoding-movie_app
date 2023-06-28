import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/tv_series_watchlist_remove/tv_series_watchlist_remove_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_remove_bloc_test.mocks.dart';

@GenerateMocks([RemoveWatchlistTv])
void main() {
  late TvSeriesWatchlistRemoveBloc bloc;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();

    bloc = TvSeriesWatchlistRemoveBloc(
      removeWatchlistTv: mockRemoveWatchlistTv,
    );
  });

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesWatchlistRemoveInitial());
    });

    blocTest<TvSeriesWatchlistRemoveBloc, TvSeriesWatchlistRemoveState>(
      'emits loading and success when AddTvSeriesWatchlistEvent added.',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Success'),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlistRemoveEvent(testTvSeriesDetail)),
      expect: () => <TvSeriesWatchlistRemoveState>[
        TvSeriesWatchlistRemoveLoading(),
        TvSeriesWatchlistRemoveSuccess('Success'),
      ],
    );

    blocTest<TvSeriesWatchlistRemoveBloc, TvSeriesWatchlistRemoveState>(
      'emits loading and failed when AddTvSeriesWatchlistEvent added.',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlistRemoveEvent(testTvSeriesDetail)),
      expect: () => <TvSeriesWatchlistRemoveState>[
        TvSeriesWatchlistRemoveLoading(),
        TvSeriesWatchlistRemoveFailure('Error'),
      ],
    );
  });
}
