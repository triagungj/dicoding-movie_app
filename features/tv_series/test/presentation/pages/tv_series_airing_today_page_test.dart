import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'mock_bloc_tv_series.dart';

void main() {
  late MockTvSeriesAiringTodayBloc mockTvSeriesAiringTodayBloc;

  setUp(() {
    mockTvSeriesAiringTodayBloc = MockTvSeriesAiringTodayBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesAiringTodayBloc>(
      create: (context) => mockTvSeriesAiringTodayBloc,
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

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesAiringTodayPage()),
          );
          final loadingWidgets = find.byType(CircularProgressIndicator);

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of TV Series',
        (tester) async {
          when(() => mockTvSeriesAiringTodayBloc.state).thenReturn(
            TvSeriesAiringTodaySuccess(const [testTvSeries]),
          );

          final tvSeriesListWidgets = find.byType(TvSeriesCard);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesAiringTodayPage()),
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

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesAiringTodayPage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );
}
