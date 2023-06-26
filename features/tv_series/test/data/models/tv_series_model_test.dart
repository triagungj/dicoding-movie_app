import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    id: 209265,
    name: 'Terra e Paixão',
    overview: 'lorem ipsum dolores sit amet',
    posterPath: '/voaKRrYExZNkf1E4FZExU7fTd8w.jpg',
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

  const tTvSeries = TvSeries(
    id: 209265,
    name: 'Terra e Paixão',
    overview: 'lorem ipsum dolores sit amet',
    posterPath: '/voaKRrYExZNkf1E4FZExU7fTd8w.jpg',
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

  test('should be a subclass of Movie entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
  test('should convert from map', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
