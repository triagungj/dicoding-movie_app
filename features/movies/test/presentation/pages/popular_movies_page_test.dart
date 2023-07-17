import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
