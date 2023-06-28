import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_top_rated.dart';
import 'package:tv_series/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late TvSeriesTopRatedBloc bloc;
  late MockGetTvTopRated mockGetTvSearch;

  setUp(() {
    mockGetTvSearch = MockGetTvTopRated();

    bloc = TvSeriesTopRatedBloc(
      getTvTopRated: mockGetTvSearch,
    );
  });

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesTopRatedInitial());
    });

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'emits loading and success when GetTvSeriesTopRatedEvent added.',
      build: () {
        when(mockGetTvSearch.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesTopRatedEvent()),
      expect: () => <TvSeriesTopRatedState>[
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedSuccess(const [testTvSeries]),
      ],
    );

    blocTest<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
      'emits loading and failed when GetTvSeriesTopRatedEvent added.',
      build: () {
        when(mockGetTvSearch.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesTopRatedEvent()),
      expect: () => <TvSeriesTopRatedState>[
        TvSeriesTopRatedLoading(),
        TvSeriesTopRatedFailure('Error'),
      ],
    );
  });
}
