import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
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
        'should display list of TV Series with default icon if image empty',
        (tester) async {
          const tvSeries = TvSeries(
            id: 209265,
            name: 'Terra e Paixão',
            overview: 'lorem ipsum dolores sit amet',
            // posterPath: '/voaKRrYExZNkf1E4FZExU7fTd8w.jpg',
            firstAirDate: '2023-05-08',
            genreIds: [18, 80, 10766],
            originCountry: ['BR'],
            originalLanguage: 'pt',
            originalName: 'Terra e Paixão',
            popularity: 2985.435,
            voteAverage: 6.6,
            voteCount: 5,
            backdropPath: '/aWPhMZ0P2DyfWB7k5NXhGHSZHGC.jpg',
          );

          final iconImage = find.byIcon(Icons.image);

          when(() => mockTvSeriesPopularBloc.state).thenReturn(
            TvSeriesPopularSuccess(const [tvSeries]),
          );

          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesPopularListPage()),
          );

          expect(iconImage, findsOneWidget);
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
