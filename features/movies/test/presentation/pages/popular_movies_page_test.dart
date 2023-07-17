import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/movies_popular/movies_popular_bloc.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_mock_bloc.dart';

void main() {
  late MockMoviesPopularBloc mockMoviesPopularBloc;

  setUp(() {
    mockMoviesPopularBloc = MockMoviesPopularBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MoviesPopularBloc>(
      create: (context) => mockMoviesPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Home Page Popular Movie Section',
    () {
      testWidgets(
        'should display loading widgets when load movies',
        (tester) async {
          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularLoading(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const PopularMoviesPage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );

      testWidgets(
        'should display list of Movies with default icon if image empty',
        (tester) async {
          const movie = Movie(
            adult: false,
            backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
            genreIds: [14, 28],
            id: 557,
            originalTitle: 'Spider-Man',
            overview:
                '''After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.''',
            popularity: 60.441,
            // posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
            releaseDate: '2002-05-01',
            title: 'Spider-Man',
            video: false,
            voteAverage: 7.2,
            voteCount: 13507,
          );
          final iconImage = find.byIcon(Icons.image);

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularSuccess(const [movie]),
          );

          await tester.pumpWidget(
            makeTestableWidget(const PopularMoviesPage()),
          );

          expect(iconImage, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularSuccess(const [testMovie]),
          );

          final movieListWidget = find.byType(MovieCard);

          await tester.pumpWidget(
            makeTestableWidget(const PopularMoviesPage()),
          );

          expect(movieListWidget, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularFailure('Failed get data'),
          );

          final moviesFailure = find.text('Failed get data');

          await tester.pumpWidget(
            makeTestableWidget(const PopularMoviesPage()),
          );

          expect(moviesFailure, findsOneWidget);
        },
      );
    },
  );
}
