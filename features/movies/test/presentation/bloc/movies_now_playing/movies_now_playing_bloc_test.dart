import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/movies.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MoviesNowPlayingBloc bloc;
  late MockGetNowPlayingMovies mockGetMoviesNowPlaying;

  setUp(() {
    mockGetMoviesNowPlaying = MockGetNowPlayingMovies();

    bloc = MoviesNowPlayingBloc(
      getNowPlayingMovies: mockGetMoviesNowPlaying,
    );
  });

  group('Movies Now Playing', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MoviesNowPlayingInitial());
    });

    blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
      'emits loading and success when GetNowPlayingMoviesEvent added.',
      build: () {
        when(mockGetMoviesNowPlaying.execute()).thenAnswer(
          (_) async => const Right([testMovie]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
      expect: () => <MoviesNowPlayingState>[
        MoviesNowPlayingLoading(),
        MoviesNowPlayingSuccess(const [testMovie]),
      ],
    );

    blocTest<MoviesNowPlayingBloc, MoviesNowPlayingState>(
      'emits loading and failed when GetNowPlayingMoviesEvent added.',
      build: () {
        when(mockGetMoviesNowPlaying.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetNowPlayingMoviesEvent()),
      expect: () => <MoviesNowPlayingState>[
        MoviesNowPlayingLoading(),
        MoviesNowPlayingFailure('Error'),
      ],
    );
  });
}
