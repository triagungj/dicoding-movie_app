import 'package:bloc_test/bloc_test.dart';
import 'package:common/genre.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/movies_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_mock_bloc.dart';

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMoviesRecommendationBloc mockMoviesRecommendationBloc;
  late MockMovieWatchlistStatusBloc mockMovieWatchlistStatusBloc;
  late MockMovieWatchlistInsertBloc mockMovieWatchlistInsertBloc;
  late MockMovieWatchlistRemoveBloc mockMovieWatchlistRemoveBloc;
  const movieId = 1;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMoviesRecommendationBloc = MockMoviesRecommendationBloc();
    mockMovieWatchlistStatusBloc = MockMovieWatchlistStatusBloc();
    mockMovieWatchlistInsertBloc = MockMovieWatchlistInsertBloc();
    mockMovieWatchlistRemoveBloc = MockMovieWatchlistRemoveBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MoviesRecommendationBloc>(
          create: (context) => mockMoviesRecommendationBloc,
        ),
        BlocProvider<MovieWatchlistStatusBloc>(
          create: (context) => mockMovieWatchlistStatusBloc,
        ),
        BlocProvider<MovieWatchlistInsertBloc>(
          create: (context) => mockMovieWatchlistInsertBloc,
        ),
        BlocProvider<MovieWatchlistRemoveBloc>(
          create: (context) => mockMovieWatchlistRemoveBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Detail Page', () {
    testWidgets(
      '''should display default image when imagePath movie is null & runtime < 1 hour''',
      (WidgetTester tester) async {
        const testMovieDetail = MovieDetail(
          adult: false,
          backdropPath: 'backdropPath',
          genres: [Genre(id: 1, name: 'Action')],
          id: 1,
          originalTitle: 'originalTitle',
          overview: 'overview',
          // posterPath: 'posterPath',
          releaseDate: 'releaseDate',
          runtime: 48,
          title: 'title',
          voteAverage: 1,
          voteCount: 1,
        );
        when(() => mockMovieDetailBloc.state)
            .thenReturn(MovieDetailSuccess(testMovieDetail));

        when(() => mockMoviesRecommendationBloc.state)
            .thenReturn(MoviesRecommendationSuccess(const [testMovie]));

        when(() => mockMovieWatchlistStatusBloc.state).thenReturn(true);
        when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
          MovieWatchlistInsertInitial(),
        );
        when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
          MovieWatchlistRemoveInitial(),
        );

        final containerPoster = find.byKey(const Key('containerPoster'));

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: movieId)));

        expect(containerPoster, findsOneWidget);
      },
    );
    testWidgets('should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));

      when(() => mockMoviesRecommendationBloc.state)
          .thenReturn(MoviesRecommendationSuccess(const [testMovie]));

      when(() => mockMovieWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
        MovieWatchlistInsertInitial(),
      );
      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveInitial(),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(makeTestableWidget(const MovieDetailPage(id: movieId)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'should display Error Message if state movie detail return failure',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailFailure('Failed get data'));

      when(() => mockMoviesRecommendationBloc.state)
          .thenReturn(MoviesRecommendationInitial());

      // when(() => mockMovieWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
        MovieWatchlistInsertInitial(),
      );
      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveInitial(),
      );

      final textErrorWidget = find.byKey(const Key('textErrorWidget'));

      await tester
          .pumpWidget(makeTestableWidget(const MovieDetailPage(id: movieId)));

      expect(textErrorWidget, findsOneWidget);
    });

    testWidgets(
        '''should display Error Message if state movie recommendation return failure''',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));

      when(() => mockMoviesRecommendationBloc.state)
          .thenReturn(MoviesRecommendationFailure('Failed get data'));

      when(() => mockMovieWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
        MovieWatchlistInsertInitial(),
      );
      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveInitial(),
      );

      final textRecommendationError =
          find.byKey(const Key('textRecommendationError'));

      await tester.pumpWidget(
        makeTestableWidget(const MovieDetailPage(id: movieId)),
      );

      expect(textRecommendationError, findsOneWidget);
    });

    testWidgets('should display success message when movie added to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));

      when(() => mockMoviesRecommendationBloc.state)
          .thenReturn(MoviesRecommendationSuccess(const [testMovie]));

      when(() => mockMovieWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
        MovieWatchlistInsertInitial(),
      );
      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveInitial(),
      );

      final expectedStates = [
        MovieWatchlistInsertInitial(),
        MovieWatchlistInsertSuccess('Added to Watchlist')
      ];

      final watchlistButton = find.byType(ElevatedButton);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(makeTestableWidget(const MovieDetailPage(id: movieId)));

      expect(watchlistButtonIcon, findsOneWidget);

      await tester.tap(watchlistButton);

      whenListen(
        mockMovieWatchlistInsertBloc,
        Stream.fromIterable(expectedStates),
      );

      await tester.pump();

      expect(find.text('Added to Watchlist'), findsNothing);
    });

    testWidgets(
        'should display success message when movie removed to watchlist',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));

      when(() => mockMoviesRecommendationBloc.state)
          .thenReturn(MoviesRecommendationSuccess(const [testMovie]));

      when(() => mockMovieWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
        MovieWatchlistInsertInitial(),
      );
      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveInitial(),
      );

      final expectedStates = [
        MovieWatchlistRemoveInitial(),
        MovieWatchlistRemoveSuccess('Removed to Watchlist')
      ];

      final watchlistButton = find.byType(ElevatedButton);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(makeTestableWidget(const MovieDetailPage(id: movieId)));

      expect(watchlistButtonIcon, findsOneWidget);

      await tester.tap(watchlistButton);

      whenListen(
        mockMovieWatchlistRemoveBloc,
        Stream.fromIterable(expectedStates),
      );

      await tester.pump();

      expect(find.text('Removed to Watchlist'), findsNothing);
    });

    testWidgets(
        '''should display failure message when movie failed to remove from watchlist''',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailSuccess(testMovieDetail));

      when(() => mockMoviesRecommendationBloc.state)
          .thenReturn(MoviesRecommendationSuccess(const [testMovie]));

      when(() => mockMovieWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockMovieWatchlistInsertBloc.state).thenReturn(
        MovieWatchlistInsertInitial(),
      );
      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveInitial(),
      );
      final watchlistButton = find.byType(ElevatedButton);

      final alertDialog = find.byType(AlertDialog);

      await tester
          .pumpWidget(makeTestableWidget(const MovieDetailPage(id: movieId)));

      expect(watchlistButton, findsOneWidget);

      await tester.tap(watchlistButton);

      when(() => mockMovieWatchlistRemoveBloc.state).thenReturn(
        MovieWatchlistRemoveFailure('Failed to remove from Watchlist'),
      );
      await tester.pump();

      expect(alertDialog, findsNothing);
    });
  });
}
