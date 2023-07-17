import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'mock_bloc_tv_series.dart';

void main() {
  late MockTvSeriesSearchBloc mockTvSeriesSearchBloc;

  setUp(() {
    mockTvSeriesSearchBloc = MockTvSeriesSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesSearchBloc>(
      create: (context) => mockTvSeriesSearchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'Home Page Popular Movie Section',
    () {
      testWidgets(
        'should display loading widgets when load tvSeriess',
        (tester) async {
          when(() => mockTvSeriesSearchBloc.state).thenReturn(
            TvSeriesSearchInitial(),
          );

          final emptyContainer = find.byKey(const Key('emptyContainer'));

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesSearchPage()),
          );

          expect(emptyContainer, findsOneWidget);
        },
      );
      testWidgets(
        'should display loading widgets when load tvSeriess',
        (tester) async {
          when(() => mockTvSeriesSearchBloc.state).thenReturn(
            TvSeriesSearchLoading(),
          );

          final loadingWidgets = find.byType(CircularProgressIndicator);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesSearchPage()),
          );

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of Movies',
        (tester) async {
          when(() => mockTvSeriesSearchBloc.state).thenReturn(
            TvSeriesSearchSuccess(const [testTvSeries]),
          );

          final tvSeriesListWidget = find.byType(TvSeriesCard);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesSearchPage()),
          );

          expect(tvSeriesListWidget, findsOneWidget);
        },
      );
      testWidgets(
        'should display error text when failure',
        (tester) async {
          when(() => mockTvSeriesSearchBloc.state).thenReturn(
            TvSeriesSearchFailure('Error Text'),
          );

          final tvSeriesListWidget = find.text('Error Text');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesSearchPage()),
          );

          expect(tvSeriesListWidget, findsOneWidget);
        },
      );
    },
  );
}
