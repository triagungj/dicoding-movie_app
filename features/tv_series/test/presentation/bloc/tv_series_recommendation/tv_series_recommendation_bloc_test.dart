import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/presentation/bloc/tv_series_recommendation/tv_series_recommendations_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvSeriesRecommendationsBloc bloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();

    bloc = TvSeriesRecommendationsBloc(
      getTvRecommendations: mockGetTvRecommendations,
    );
  });

  const tvId = 1;

  group('TV Series Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesRecommendationsInitial());
    });

    blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
      'emits loading and success when GetTvSeriesRecommendationsEvent added.',
      build: () {
        when(mockGetTvRecommendations.execute(tvId)).thenAnswer(
          (_) async => const Right([testTvSeries]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesRecommendationsEvent(tvId)),
      expect: () => <TvSeriesRecommendationsState>[
        TvSeriesRecommendationsLoading(),
        TvSeriesRecommendationsSuccess(const [testTvSeries]),
      ],
    );

    blocTest<TvSeriesRecommendationsBloc, TvSeriesRecommendationsState>(
      'emits loading and failed when GetTvSeriesRecommendationsEvent added.',
      build: () {
        when(mockGetTvRecommendations.execute(tvId)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesRecommendationsEvent(tvId)),
      expect: () => <TvSeriesRecommendationsState>[
        TvSeriesRecommendationsLoading(),
        TvSeriesRecommendationsFailure('Error'),
      ],
    );
  });
}
