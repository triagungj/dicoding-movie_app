import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_insert_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistTv])
void main() {
  late TvSeriesWatchlistInsertBloc bloc;
  late MockSaveWatchlistTv mockGetTvSearch;

  setUp(() {
    mockGetTvSearch = MockSaveWatchlistTv();

    bloc = TvSeriesWatchlistInsertBloc(
      saveWatchlistTv: mockGetTvSearch,
    );
  });

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesWatchlistInsertInitial());
    });

    blocTest<TvSeriesWatchlistInsertBloc, TvSeriesWatchlistInsertState>(
      'emits loading and success when AddTvSeriesWatchlistInsertEvent added.',
      build: () {
        when(mockGetTvSearch.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Right('Success'),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlistInsertEvent(testTvSeriesDetail)),
      expect: () => <TvSeriesWatchlistInsertState>[
        TvSeriesWatchlistInsertLoading(),
        TvSeriesWatchlistInsertSuccess('Success'),
      ],
    );

    blocTest<TvSeriesWatchlistInsertBloc, TvSeriesWatchlistInsertState>(
      'emits loading and failed when AddTvSeriesWatchlistInsertEvent added.',
      build: () {
        when(mockGetTvSearch.execute(testTvSeriesDetail)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) =>
          bloc.add(AddTvSeriesWatchlistInsertEvent(testTvSeriesDetail)),
      expect: () => <TvSeriesWatchlistInsertState>[
        TvSeriesWatchlistInsertLoading(),
        TvSeriesWatchlistInsertFailure('Error'),
      ],
    );
  });
}
