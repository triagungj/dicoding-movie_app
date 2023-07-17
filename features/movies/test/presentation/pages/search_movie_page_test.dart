import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movies_search/movies_search_bloc.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_mock_bloc.dart';

void main() {
  late MockMoviesSearchBloc mockMoviesSearchBloc;

  setUp(() {
    mockMoviesSearchBloc = MockMoviesSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MoviesSearchBloc>(
      create: (context) => mockMoviesSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Home Page Popular Movie Section',
    () {
      testWidgets(
        'should display empty container when init',
        (tester) async {
          when(() => mockMoviesSearchBloc.state).thenReturn(
            MoviesSearchInitial(),
          );

          final emptyContainer = find.byKey(const Key('emptyContainer'));

          await tester.pumpWidget(
            makeTestableWidget(const SearchMoviePage()),
          );

          expect(emptyContainer, findsOneWidget);
        },
      );
      testWidgets(
        'should display loading widgets when load movies',
        (tester) async {
          when(() => mockMoviesSearchBloc.state).thenReturn(
            MoviesSearchLoading(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const SearchMoviePage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockMoviesSearchBloc.state).thenReturn(
            MoviesSearchSuccess(const [testMovie]),
          );

          final movieListWidget = find.byType(MovieCard);

          await tester.pumpWidget(
            makeTestableWidget(const SearchMoviePage()),
          );

          expect(movieListWidget, findsOneWidget);
        },
      );
    },
  );
}
