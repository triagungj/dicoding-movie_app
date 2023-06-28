import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/remove_watchlist_movie.dart';
import 'package:movies/presentation/bloc/movie_watchlist_remove/movie_watchlist_remove_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_remove_bloc_test.mocks.dart';

@GenerateMocks([RemoveWatchlistMovie])
void main() {
  late MovieWatchlistRemoveBloc bloc;
  late MockRemoveWatchlistMovie mockGetMovieWatchlistRemove;

  setUp(() {
    mockGetMovieWatchlistRemove = MockRemoveWatchlistMovie();

    bloc = MovieWatchlistRemoveBloc(
      removeWatchlistMovie: mockGetMovieWatchlistRemove,
    );
  });

  group('Movies Popular', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MovieWatchlistRemoveInitial());
    });

    blocTest<MovieWatchlistRemoveBloc, MovieWatchlistRemoveState>(
      'emits loading and success when AddMovieWatchlistRemoveEvent added.',
      build: () {
        when(mockGetMovieWatchlistRemove.execute(testMovieDetail)).thenAnswer(
          (_) async => const Right('Success'),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlistRemoveEvent(testMovieDetail)),
      expect: () => <MovieWatchlistRemoveState>[
        MovieWatchlistRemoveLoading(),
        MovieWatchlistRemoveSuccess('Success'),
      ],
    );

    blocTest<MovieWatchlistRemoveBloc, MovieWatchlistRemoveState>(
      'emits loading and failed when AddMovieWatchlistRemoveEvent added.',
      build: () {
        when(mockGetMovieWatchlistRemove.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(AddMovieWatchlistRemoveEvent(testMovieDetail)),
      expect: () => <MovieWatchlistRemoveState>[
        MovieWatchlistRemoveLoading(),
        MovieWatchlistRemoveFailure('Error'),
      ],
    );
  });
}
