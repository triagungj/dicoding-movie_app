import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/tv_series_watchlist_load/tv_series_watchlist_load_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_load_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late TvSeriesWatchlistLoadBloc bloc;
  late MockGetWatchlistTv mockGetTvSearch;

  setUp(() {
    mockGetTvSearch = MockGetWatchlistTv();

    bloc = TvSeriesWatchlistLoadBloc(
      getWatchlistTv: mockGetTvSearch,
    );
  });

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesWatchlistLoadInitial());
    });

    blocTest<TvSeriesWatchlistLoadBloc, TvSeriesWatchlistLoadState>(
      'emits loading and success when AddTvSeriesWatchlistEvent added.',
      build: () {
        when(mockGetTvSearch.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesWatchlistLoadEvent()),
      expect: () => <TvSeriesWatchlistLoadState>[
        TvSeriesWatchlistLoadLoading(),
        TvSeriesWatchlistLoadSuccess(const [testTvSeries]),
      ],
    );

    blocTest<TvSeriesWatchlistLoadBloc, TvSeriesWatchlistLoadState>(
      'emits loading and failed when AddTvSeriesWatchlistEvent added.',
      build: () {
        when(mockGetTvSearch.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesWatchlistLoadEvent()),
      expect: () => <TvSeriesWatchlistLoadState>[
        TvSeriesWatchlistLoadLoading(),
        TvSeriesWatchlistLoadFailure('Error'),
      ],
    );
  });
}
