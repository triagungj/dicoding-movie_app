import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();

    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
    );
  });

  const movieId = 1;

  group('Movies Detail', () {
    test('initialState should be initial state', () {
      expect(bloc.state, MovieDetailInitial());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits loading and success when GetMovieDetailEvent added.',
      build: () {
        when(mockGetMovieDetail.execute(movieId)).thenAnswer(
          (_) async => const Right(testMovieDetail),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(movieId)),
      expect: () => <MovieDetailState>[
        MovieDetailLoading(),
        MovieDetailSuccess(testMovieDetail),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits loading and failed when GetMovieDetailEvent added.',
      build: () {
        when(mockGetMovieDetail.execute(movieId)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(movieId)),
      expect: () => <MovieDetailState>[
        MovieDetailLoading(),
        MovieDetailFailure('Error'),
      ],
    );
  });
}
