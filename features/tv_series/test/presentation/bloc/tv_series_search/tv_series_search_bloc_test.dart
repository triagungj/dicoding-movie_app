import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_search.dart';
import 'package:tv_series/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([GetTvSearch])
void main() {
  late TvSeriesSearchBloc bloc;
  late MockGetTvSearch mockGetTvSearch;

  setUp(() {
    mockGetTvSearch = MockGetTvSearch();

    bloc = TvSeriesSearchBloc(
      getTvSearch: mockGetTvSearch,
    );
  });

  const query = 'test';

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesSearchInitial());
    });

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'emits loading and success when GetTvSeriesSearchEvent added.',
      build: () {
        when(mockGetTvSearch.execute(query)).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesSearchEvent(query)),
      expect: () => <TvSeriesSearchState>[
        TvSeriesSearchLoading(),
        TvSeriesSearchSuccess(const [testTvSeries]),
      ],
    );

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'emits loading and failed when GetTvSeriesSearchEvent added.',
      build: () {
        when(mockGetTvSearch.execute(query)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesSearchEvent(query)),
      expect: () => <TvSeriesSearchState>[
        TvSeriesSearchLoading(),
        TvSeriesSearchFailure('Error'),
      ],
    );
  });
}
