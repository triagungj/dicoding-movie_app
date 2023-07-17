import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'mock_bloc_tv_series.dart';

void main() {
  late MockTvSeriesTopRatedBloc mockTvSeriesTopRatedBloc;

  setUp(() {
    mockTvSeriesTopRatedBloc = MockTvSeriesTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesTopRatedBloc>(
      create: (context) => mockTvSeriesTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group(
    'TV Series Top Rated List Page',
    () {
      testWidgets(
        'should display loading widgets when load TV Series',
        (tester) async {
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedLoading(),
          );

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesTopRatedListPage()),
          );
          final loadingWidgets = find.byType(CircularProgressIndicator);

          expect(loadingWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display list of TV Series',
        (tester) async {
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedSuccess(const [testTvSeries]),
          );

          final tvSeriesListWidgets = find.byType(TvSeriesCard);

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesTopRatedListPage()),
          );

          expect(tvSeriesListWidgets, findsOneWidget);
        },
      );
      testWidgets(
        'should display failure message',
        (tester) async {
          when(() => mockTvSeriesTopRatedBloc.state).thenReturn(
            TvSeriesTopRatedFailure('Failed Get Data'),
          );

          final failureText = find.text('Failed Get Data');

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesTopRatedListPage()),
          );

          expect(failureText, findsOneWidget);
        },
      );
    },
  );
}
