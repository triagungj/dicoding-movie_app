import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/presentation/bloc/tv_series_watchlist_status/tv_series_watchlist_status_bloc.dart';

import 'tv_series_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistStatusTv])
void main() {
  late TvSeriesWatchlistStatusBloc bloc;
  late MockGetWatchlistStatusTv mockRemoveWatchlistTv;

  setUp(() {
    mockRemoveWatchlistTv = MockGetWatchlistStatusTv();

    bloc = TvSeriesWatchlistStatusBloc(
      getWatchlistStatusTv: mockRemoveWatchlistTv,
    );
  });

  const tvId = 1;

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, false);
    });

    blocTest<TvSeriesWatchlistStatusBloc, bool>(
      'emits true when AddTvSeriesWatchlistEvent added.',
      build: () {
        when(mockRemoveWatchlistTv.execute(tvId)).thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetTvSeriesWatchlistStatusEvent(tvId),
      ),
      expect: () => <bool>[
        false,
        true,
      ],
    );

    blocTest<TvSeriesWatchlistStatusBloc, bool>(
      'emits false when AddTvSeriesWatchlistEvent added.',
      build: () {
        when(mockRemoveWatchlistTv.execute(tvId)).thenAnswer(
          (_) async => false,
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesWatchlistStatusEvent(tvId)),
      expect: () => <bool>[
        false,
      ],
    );
  });
}
