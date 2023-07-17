import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movies_bloc.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_mock_bloc.dart';

void main() {
  late MockMoviesTopRatedBloc mockMoviesTopRatedBloc;

  setUp(() {
    mockMoviesTopRatedBloc = MockMoviesTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MoviesTopRatedBloc>(
      create: (context) => mockMoviesTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Top Rated Movie Section',
    () {
      testWidgets(
        'should display loading widgets when load movies',
        (tester) async {
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedLoading(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const TopRatedMoviesPage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedSuccess(const [testMovie]),
          );

          final movieListWidget = find.byType(MovieCard);

          await tester.pumpWidget(
            makeTestableWidget(const TopRatedMoviesPage()),
          );

          expect(movieListWidget, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedFailure('Failed get data'),
          );

          final moviesFailure = find.text('Failed get data');

          await tester.pumpWidget(
            makeTestableWidget(const TopRatedMoviesPage()),
          );

          expect(moviesFailure, findsOneWidget);
        },
      );
    },
  );
}
