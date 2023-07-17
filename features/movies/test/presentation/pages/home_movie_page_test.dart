import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movies_bloc.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_mock_bloc.dart';

void main() {
  late MockMoviesNowPlayingBloc mockMoviesNowPlayingBloc;
  late MockMoviesPopularBloc mockMoviesPopularBloc;
  late MockMoviesTopRatedBloc mockMoviesTopRatedBloc;

  setUp(() {
    mockMoviesNowPlayingBloc = MockMoviesNowPlayingBloc();
    mockMoviesPopularBloc = MockMoviesPopularBloc();
    mockMoviesTopRatedBloc = MockMoviesTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesNowPlayingBloc>(
          create: (context) => mockMoviesNowPlayingBloc,
        ),
        BlocProvider<MoviesPopularBloc>(
          create: (context) => mockMoviesPopularBloc,
        ),
        BlocProvider<MoviesTopRatedBloc>(
          create: (context) => mockMoviesTopRatedBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Home Page Now Playing Section',
    () {
      testWidgets(
        'should display loading widgets when load movies',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingLoading(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularInitial(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedInitial(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingSuccess(const [testMovie]),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularInitial(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedInitial(),
          );

          final movieListWidgets = find.byType(MovieList);

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(movieListWidgets, findsOneWidget);
        },
      );

      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingFailure('Failed Get Data'),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularInitial(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedInitial(),
          );

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );
  group(
    'Home Page Popular Movie Section',
    () {
      testWidgets(
        'should display loading widgets when load movies',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingInitial(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularLoading(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedInitial(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingInitial(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularSuccess(const [testMovie]),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedInitial(),
          );

          final movieListWidget = find.byType(MovieList);

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(movieListWidget, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingInitial(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularFailure('Failed get data'),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedInitial(),
          );

          final moviesFailure = find.text('Failed get data');

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(moviesFailure, findsOneWidget);
        },
      );
      // testWidgets(
      //   'should direct into popular page when button See All taped',
      //   (tester) async {
      //     when(() => mockMoviesNowPlayingBloc.state).thenReturn(
      //       MoviesNowPlayingInitial(),
      //     );

      //     when(() => mockMoviesPopularBloc.state).thenReturn(
      //       MoviesPopularInitial(),
      //     );
      //     when(() => mockMoviesTopRatedBloc.state).thenReturn(
      //       MoviesTopRatedInitial(),
      //     );

      //     final moviesPopular = find.byType(PopularMoviesPage);
      //     final moviesPopularKey =
      //         find.byKey(const Key('seeAllPopularMovies'));

      //     await tester.pumpWidget(
      //       makeTestableWidget(const HomeMoviePage()),
      //     );

      //     await tester.tap(moviesPopularKey);

      //     await tester.pumpAndSettle();
      //     verify(() => mockObserver.didPush(any(), any()));

      //     expect(moviesPopular, findsOneWidget);
      //   },
      // );
    },
  );

  group(
    'Home Page Top Rated Movie Section',
    () {
      testWidgets(
        'should display loading widgets when load movies',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingInitial(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularInitial(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedLoading(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingInitial(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularInitial(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedSuccess(const [testMovie]),
          );

          final movieListWidget = find.byType(MovieList);

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(movieListWidget, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockMoviesNowPlayingBloc.state).thenReturn(
            MoviesNowPlayingInitial(),
          );

          when(() => mockMoviesPopularBloc.state).thenReturn(
            MoviesPopularInitial(),
          );
          when(() => mockMoviesTopRatedBloc.state).thenReturn(
            MoviesTopRatedFailure('Failed get data'),
          );

          final moviesFailure = find.text('Failed get data');

          await tester.pumpWidget(
            makeTestableWidget(const HomeMoviePage()),
          );

          expect(moviesFailure, findsOneWidget);
        },
      );
    },
  );
}
