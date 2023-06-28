import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/movies_recommendations/movies_recommendation_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MoviesRecommendationBloc bloc;
  late MockGetMovieRecommendations mockGetMoviesRecommendation;

  setUp(() {
    mockGetMoviesRecommendation = MockGetMovieRecommendations();

    bloc = MoviesRecommendationBloc(
      getMovieRecommendations: mockGetMoviesRecommendation,
    );
  });
  const movieId = 1;

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MoviesRecommendationInitial());
    });

    blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
      'emits loading and success when GetMoviesRecommendationEvent added.',
      build: () {
        when(mockGetMoviesRecommendation.execute(movieId)).thenAnswer(
          (_) async => const Right([testMovie]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesRecommendationEvent(movieId)),
      expect: () => <MoviesRecommendationState>[
        MoviesRecommendationLoading(),
        MoviesRecommendationSuccess(const [testMovie]),
      ],
    );

    blocTest<MoviesRecommendationBloc, MoviesRecommendationState>(
      'emits loading and failed when GetMoviesRecommendationEvent added.',
      build: () {
        when(mockGetMoviesRecommendation.execute(movieId)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesRecommendationEvent(movieId)),
      expect: () => <MoviesRecommendationState>[
        MoviesRecommendationLoading(),
        MoviesRecommendationFailure('Error'),
      ],
    );
  });
}
