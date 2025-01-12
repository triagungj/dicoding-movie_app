import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_list_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'mock_bloc_tv_series.dart';

void main() {
  late MockTvSeriesAiringTodayBloc mockTvSeriesAiringTodayBloc;
  late MockTvSeriesPopularBloc mockTvSeriesPopularBloc;
  late MockTvSeriesTopRatedBloc mockTvSeriesTopRatedBloc;

  setUp(() {
    mockTvSeriesAiringTodayBloc = MockTvSeriesAiringTodayBloc();
    mockTvSeriesPopularBloc = MockTvSeriesPopularBloc();
    mockTvSeriesTopRatedBloc = MockTvSeriesTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesAiringTodayBloc>(
          create: (context) => mockTvSeriesAiringTodayBloc,
        ),
        BlocProvider<TvSeriesPopularBloc>(
          create: (context) => mockTvSeriesPopularBloc,
        ),
        BlocProvider<TvSeriesTopRatedBloc>(
          create: (context) => mockTvSeriesTopRatedBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Home Page Airing Today Section',
    () {
      testWidgets(
        'should display loading widgets when load Tv Series',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayLoading(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularInitial(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedInitial(),
          );

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );
          final loadingWidgets = find.byType(CircularProgressIndicator);

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodaySuccess(const [testTvSeries]),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularInitial(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedInitial(),
          );

          final tvSeriesListWidgets = find.byType(TvSeriesListWidget);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );

          expect(tvSeriesListWidgets, findsOneWidget);
        },
      );

      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayFailure('Failed Get Data'),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularInitial(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedInitial(),
          );

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );

  group(
    'Home Page Popular Section',
    () {
      testWidgets(
        'should display loading widgets when load Tv Series',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayInitial(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularLoading(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedInitial(),
          );

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );
          final loadingWidgets = find.byType(CircularProgressIndicator);

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayInitial(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularSuccess(const [testTvSeries]),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedInitial(),
          );

          final tvSeriesListWidgets = find.byType(TvSeriesListWidget);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );

          expect(tvSeriesListWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayInitial(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularFailure('Failed Get Data'),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedInitial(),
          );

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );

  group(
    'Tv Series Top Rated Section',
    () {
      testWidgets(
        'should display loading widgets when load Tv Series',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayInitial(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularInitial(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedLoading(),
          );

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );
          final loadingWidgets = find.byType(CircularProgressIndicator);

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayInitial(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularInitial(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedSuccess(const [testTvSeries]),
          );

          final tvSeriesListWidgets = find.byType(TvSeriesListWidget);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );

          expect(tvSeriesListWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodayInitial(),
          );

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularInitial(),
          );
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedFailure('Failed Get Data'),
          );

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesListPage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );
}
