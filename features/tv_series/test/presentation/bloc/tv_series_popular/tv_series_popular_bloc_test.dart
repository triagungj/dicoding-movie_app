import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_popular.dart';
import 'package:tv_series/tv_series.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetTvPopular])
void main() {
  late TvSeriesPopularBloc bloc;
  late MockGetTvPopular mockGetTvPopular;

  setUp(() {
    mockGetTvPopular = MockGetTvPopular();

    bloc = TvSeriesPopularBloc(
      getTvPopular: mockGetTvPopular,
    );
  });

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesPopularInitial());
    });

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'emits loading and success when GetTvSeriesPopularEvent added.',
      build: () {
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesPopularEvent()),
      expect: () => <TvSeriesPopularState>[
        TvSeriesPopularLoading(),
        TvSeriesPopularSuccess(const [testTvSeries]),
      ],
    );

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'emits loading and failed when GetTvSeriesPopularEvent added.',
      build: () {
        when(mockGetTvPopular.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesPopularEvent()),
      expect: () => <TvSeriesPopularState>[
        TvSeriesPopularLoading(),
        TvSeriesPopularFailure('Error'),
      ],
    );
  });
}
