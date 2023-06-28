import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movies/presentation/bloc/movie_watchlist_status/movie_watchlist_status_bloc.dart';

import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatusMovie])
void main() {
  late MovieWatchlistStatusBloc bloc;
  late MockGetWatchListStatusMovie mockRemoveWatchlistTv;

  setUp(() {
    mockRemoveWatchlistTv = MockGetWatchListStatusMovie();

    bloc = MovieWatchlistStatusBloc(
      getWatchListStatusMovie: mockRemoveWatchlistTv,
    );
  });

  const movieId = 1;

  group('Movies Status', () {
    test('initialState should be initial state', () {
      expect(bloc.state, false);
    });

    blocTest<MovieWatchlistStatusBloc, bool>(
      'emits true when AddMovieWatchlistEvent added.',
      build: () {
        when(mockRemoveWatchlistTv.execute(movieId)).thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        GetMovieWatchlistStatusEvent(movieId),
      ),
      expect: () => <bool>[
        true,
      ],
    );

    blocTest<MovieWatchlistStatusBloc, bool>(
      'emits false when AddMovieWatchlistEvent added.',
      build: () {
        when(mockRemoveWatchlistTv.execute(movieId)).thenAnswer(
          (_) async => false,
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieWatchlistStatusEvent(movieId)),
      expect: () => <bool>[
        false,
      ],
    );
  });
}
