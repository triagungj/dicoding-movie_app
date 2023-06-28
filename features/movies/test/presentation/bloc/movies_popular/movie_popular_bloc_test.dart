import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/presentation/bloc/movies_popular/movies_popular_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MoviesPopularBloc bloc;
  late MockGetPopularMovies mockGetMoviesPopular;

  setUp(() {
    mockGetMoviesPopular = MockGetPopularMovies();

    bloc = MoviesPopularBloc(
      getPopularMovies: mockGetMoviesPopular,
    );
  });

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MoviesPopularInitial());
    });

    blocTest<MoviesPopularBloc, MoviesPopularState>(
      'emits loading and success when GetMoviesPopularEvent added.',
      build: () {
        when(mockGetMoviesPopular.execute()).thenAnswer(
          (_) async => const Right([testMovie]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesPopularEvent()),
      expect: () => <MoviesPopularState>[
        MoviesPopularLoading(),
        MoviesPopularSuccess(const [testMovie]),
      ],
    );

    blocTest<MoviesPopularBloc, MoviesPopularState>(
      'emits loading and failed when GetMoviesPopularEvent added.',
      build: () {
        when(mockGetMoviesPopular.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesPopularEvent()),
      expect: () => <MoviesPopularState>[
        MoviesPopularLoading(),
        MoviesPopularFailure('Error'),
      ],
    );
  });
}
