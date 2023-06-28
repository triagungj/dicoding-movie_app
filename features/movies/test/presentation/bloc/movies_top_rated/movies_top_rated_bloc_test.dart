import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/movies_top_rated/movies_top_rated_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MoviesTopRatedBloc bloc;
  late MockGetTopRatedMovies mockGetMoviesTopRated;

  setUp(() {
    mockGetMoviesTopRated = MockGetTopRatedMovies();

    bloc = MoviesTopRatedBloc(
      getTopRatedMovies: mockGetMoviesTopRated,
    );
  });

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MoviesTopRatedInitial());
    });

    blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
      'emits loading and success when GetMoviesTopRatedEvent added.',
      build: () {
        when(mockGetMoviesTopRated.execute()).thenAnswer(
          (_) async => const Right([testMovie]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesTopRatedEvent()),
      expect: () => <MoviesTopRatedState>[
        MoviesTopRatedLoading(),
        MoviesTopRatedSuccess(const [testMovie]),
      ],
    );

    blocTest<MoviesTopRatedBloc, MoviesTopRatedState>(
      'emits loading and failed when GetMoviesTopRatedEvent added.',
      build: () {
        when(mockGetMoviesTopRated.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesTopRatedEvent()),
      expect: () => <MoviesTopRatedState>[
        MoviesTopRatedLoading(),
        MoviesTopRatedFailure('Error'),
      ],
    );
  });
}
