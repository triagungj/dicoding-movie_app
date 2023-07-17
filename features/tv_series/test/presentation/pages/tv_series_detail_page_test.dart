import 'package:bloc_test/bloc_test.dart';
import 'package:common/genre.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'mock_bloc_tv_series.dart';

void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationsBloc mockTvSeriesRecommendationsBloc;
  late MockTvSeriesWatchlistStatusBloc mockTvSeriesWatchlistStatusBloc;
  late MockTvSeriesWatchlistInsertBloc mockTvSeriesWatchlistInsertBloc;
  late MockTvSeriesWatchlistRemoveBloc mockTvSeriesWatchlistRemoveBloc;
  const tvSeriesId = 1;

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationsBloc = MockTvSeriesRecommendationsBloc();
    mockTvSeriesWatchlistStatusBloc = MockTvSeriesWatchlistStatusBloc();
    mockTvSeriesWatchlistInsertBloc = MockTvSeriesWatchlistInsertBloc();
    mockTvSeriesWatchlistRemoveBloc = MockTvSeriesWatchlistRemoveBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (context) => mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesRecommendationsBloc>(
          create: (context) => mockTvSeriesRecommendationsBloc,
        ),
        BlocProvider<TvSeriesWatchlistStatusBloc>(
          create: (context) => mockTvSeriesWatchlistStatusBloc,
        ),
        BlocProvider<TvSeriesWatchlistInsertBloc>(
          create: (context) => mockTvSeriesWatchlistInsertBloc,
        ),
        BlocProvider<TvSeriesWatchlistRemoveBloc>(
          create: (context) => mockTvSeriesWatchlistRemoveBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('TvSeries Detail Page', () {
    testWidgets('should display default image when imagePath tvSeries is null',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(testTvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsSuccess(const [testTvSeries]));

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final containerPoster = find.byKey(const Key('containerPoster'));

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(containerPoster, findsOneWidget);
    });
    testWidgets('should display add icon when tvSeries not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(testTvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsSuccess(const [testTvSeries]));

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'should display Error Message if state tvSeries detail return failure',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailFailure('Failed get data'));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsInitial());

      // when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final textErrorWidget = find.byKey(const Key('textErrorWidget'));

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(textErrorWidget, findsOneWidget);
    });

    testWidgets(
        '''should display Error Message if state tvSeries recommendation return failure''',
        (WidgetTester tester) async {
      const tvSeason = Season(
        id: 123,
        name: 'Season 1',
        overview: 'lorem ipsum',
        seasonNumber: 1,
        episodeCount: 69,
        posterPath: '/p2329842er2fsjio23.jpg',
      );

      const tvSeriesDetail = TvSeriesDetail(
        id: 1,
        adult: true,
        backdropPath: '/32eu9d2dd.jpg',
        firstAirDate: '2023-01-01',
        genres: [Genre(id: 1, name: 'Action')],
        lastAirDate: '2023-04-01',
        name: 'Forever',
        numberOfEpisodes: 12,
        numberOfSeasons: 2,
        overview: 'Lorem ipsum',
        posterPath: '/2837289.jpg',
        status: 'Ongoing',
        voteAverage: 9.1,
        voteCount: 230,
        seasons: [tvSeason],
      );

      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(tvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsFailure('Failed get data'));

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final textRecommendationError =
          find.byKey(const Key('textRecommendationError'));

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(textRecommendationError, findsOneWidget);
    });

    testWidgets(
        'should display empty container when get recommendation not called',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(testTvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsInitial());

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final emptyContainer = find.byKey(const Key('emptyContainer'));

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(emptyContainer, findsOneWidget);
    });

    testWidgets(
        'should display success message when tvSeries added to watchlist',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(testTvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsSuccess(const [testTvSeries]));

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final expectedStates = [
        TvSeriesWatchlistInsertInitial(),
        TvSeriesWatchlistInsertSuccess('Added to Watchlist')
      ];

      final watchlistButton = find.byType(ElevatedButton);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(watchlistButtonIcon, findsOneWidget);

      await tester.tap(watchlistButton);

      whenListen(
        mockTvSeriesWatchlistInsertBloc,
        Stream.fromIterable(expectedStates),
      );

      await tester.pump();

      expect(find.text('Added to Watchlist'), findsNothing);
    });

    testWidgets(
        'should display success message when tvSeries removed to watchlist',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(testTvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsSuccess(const [testTvSeries]));

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(false);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );

      final expectedStates = [
        TvSeriesWatchlistRemoveInitial(),
        TvSeriesWatchlistRemoveSuccess('Removed to Watchlist')
      ];

      final watchlistButton = find.byType(ElevatedButton);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(watchlistButtonIcon, findsOneWidget);

      await tester.tap(watchlistButton);

      whenListen(
        mockTvSeriesWatchlistRemoveBloc,
        Stream.fromIterable(expectedStates),
      );

      await tester.pump();

      expect(find.text('Removed to Watchlist'), findsNothing);
    });

    testWidgets(
        '''should display failure message when tvSeries failed to remove from watchlist''',
        (WidgetTester tester) async {
      when(() => mockTvSeriesDetailBloc.state)
          .thenReturn(TvSeriesDetailSuccess(testTvSeriesDetail));

      when(() => mockTvSeriesRecommendationsBloc.state)
          .thenReturn(TvSeriesRecommendationsSuccess(const [testTvSeries]));

      when(() => mockTvSeriesWatchlistStatusBloc.state).thenReturn(true);
      when(() => mockTvSeriesWatchlistInsertBloc.state).thenReturn(
        TvSeriesWatchlistInsertInitial(),
      );
      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveInitial(),
      );
      final watchlistButton = find.byType(ElevatedButton);

      final alertDialog = find.text('Failed to remove from Watchlist');

      await tester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tvSeriesId)),
      );

      expect(watchlistButton, findsOneWidget);

      await tester.tap(watchlistButton);

      when(() => mockTvSeriesWatchlistRemoveBloc.state).thenReturn(
        TvSeriesWatchlistRemoveFailure('Failed to remove from Watchlist'),
      );
      await tester.pump();

      expect(alertDialog, findsNothing);
    });
  });
}
