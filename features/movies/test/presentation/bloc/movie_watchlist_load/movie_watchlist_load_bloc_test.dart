import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/presentation/bloc/movies_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_load_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieWatchlistLoadBloc bloc;
  late MockGetWatchlistMovies mockGetMovieWatchlistLoad;

  setUp(() {
    mockGetMovieWatchlistLoad = MockGetWatchlistMovies();

    bloc = MovieWatchlistLoadBloc(
      getWatchlistMovies: mockGetMovieWatchlistLoad,
    );
  });

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MovieWatchlistLoadInitial());
    });

    blocTest<MovieWatchlistLoadBloc, MovieWatchlistLoadState>(
      'emits loading and success when GetMovieWatchlistLoadEvent added.',
      build: () {
        when(mockGetMovieWatchlistLoad.execute()).thenAnswer(
          (_) async => const Right([testMovie]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlistLoadEvent()),
      expect: () => <MovieWatchlistLoadState>[
        MovieWatchlistLoadLoading(),
        MovieWatchlistLoadSuccess(const [testMovie]),
      ],
    );

    blocTest<MovieWatchlistLoadBloc, MovieWatchlistLoadState>(
      'emits loading and failed when GetMovieWatchlistLoadEvent added.',
      build: () {
        when(mockGetMovieWatchlistLoad.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlistLoadEvent()),
      expect: () => <MovieWatchlistLoadState>[
        MovieWatchlistLoadLoading(),
        MovieWatchlistLoadFailure('Error'),
      ],
    );
  });
}
