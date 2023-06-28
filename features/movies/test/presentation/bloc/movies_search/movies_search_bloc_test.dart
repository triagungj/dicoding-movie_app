import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/bloc/movies_search/movies_search_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();

    bloc = MoviesSearchBloc(
      searchMovies: mockSearchMovies,
    );
  });
  const query = 'yuhu';

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MoviesSearchInitial());
    });

    blocTest<MoviesSearchBloc, MoviesSearchState>(
      'emits loading and success when GetMoviesSearchEvent added.',
      build: () {
        when(mockSearchMovies.execute(query)).thenAnswer(
          (_) async => const Right([testMovie]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesSearchEvent(query)),
      expect: () => <MoviesSearchState>[
        MoviesSearchLoading(),
        MoviesSearchSuccess(const [testMovie]),
      ],
    );

    blocTest<MoviesSearchBloc, MoviesSearchState>(
      'emits loading and failed when GetMoviesSearchEvent added.',
      build: () {
        when(mockSearchMovies.execute(query)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesSearchEvent(query)),
      expect: () => <MoviesSearchState>[
        MoviesSearchLoading(),
        MoviesSearchFailure('Error'),
      ],
    );
  });
}
