import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/save_watchlist_movie.dart';
import 'package:movies/presentation/bloc/movie_watchlist_insert/movie_watchlist_insert_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_insert_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlistMovie])
void main() {
  late MovieWatchlistInsertBloc bloc;
  late MockSaveWatchlistMovie mockGetMovieWatchlistInsert;

  setUp(() {
    mockGetMovieWatchlistInsert = MockSaveWatchlistMovie();

    bloc = MovieWatchlistInsertBloc(
      saveWatchlistMovie: mockGetMovieWatchlistInsert,
    );
  });

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MovieWatchlistInsertInitial());
    });

    blocTest<MovieWatchlistInsertBloc, MovieWatchlistInsertState>(
      'emits loading and success when AddMovieWatchlistInsertEvent added.',
      build: () {
        when(mockGetMovieWatchlistInsert.execute(testMovieDetail)).thenAnswer(
          (_) async => const Right('Success'),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlistInsertEvent(testMovieDetail)),
      expect: () => <MovieWatchlistInsertState>[
        MovieWatchlistInsertLoading(),
        MovieWatchlistInsertSuccess('Success'),
      ],
    );

    blocTest<MovieWatchlistInsertBloc, MovieWatchlistInsertState>(
      'emits loading and failed when AddMovieWatchlistInsertEvent added.',
      build: () {
        when(mockGetMovieWatchlistInsert.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlistInsertEvent(testMovieDetail)),
      expect: () => <MovieWatchlistInsertState>[
        MovieWatchlistInsertLoading(),
        MovieWatchlistInsertFailure('Error'),
      ],
    );
  });
}
