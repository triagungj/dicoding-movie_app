import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'mock_bloc_tv_series.dart';

void main() {
  late MockTvSeriesPopularBloc mockTvSeriesPopularBloc;

  setUp(() {
    mockTvSeriesPopularBloc = MockTvSeriesPopularBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesPopularBloc>(
      create: (context) => mockTvSeriesPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Home Page Airing Today Section',
    () {
      testWidgets(
        'should display loading widgets when load tv series',
        (tester) async {
          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularLoading(),
          );

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesPopularListPage()),
          );
          final loadingWidgets = find.byType(CircularProgressIndicator);

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularSuccess(const [testTvSeries]),
          );

          final tvSerieListWidgets = find.byType(TvSeriesCard);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesPopularListPage()),
          );

          expect(tvSerieListWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularFailure('Failed Get Data'),
          );

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesPopularListPage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );
}
