import 'package:common/genre.dart';
import 'package:common/genre_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/tv_series_detail_response.dart';
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

const testTvSeries = TvSeries(
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

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'Forever',
  overview: 'Lorem ipsum',
  posterPath: '/2837289.jpg',
);

final testTvSeriesMap = {
  'id': 1,
  'name': 'Forever',
  'overview': 'Lorem ipsum',
  'posterPath': '/2837289.jpg',
};

const testTvSeriesSeasonModel = SeasonModel(
  id: 123,
  name: 'Season 1',
  overview: 'lorem ipsum',
  seasonNumber: 1,
  episodeCount: 69,
);
const testTvSeriesSeason = Season(
  id: 123,
  name: 'Season 1',
  overview: 'lorem ipsum',
  seasonNumber: 1,
  episodeCount: 69,
);

const testTvSeriesDetailModel = TvSeriesDetailResponse(
  id: 1,
  adult: true,
  backdropPath: '/32eu9d2dd.jpg',
  firstAirDate: '2023-01-01',
  genres: [GenreModel(id: 1, name: 'Action')],
  lastAirDate: '2023-04-01',
  name: 'Forever',
  numberOfEpisodes: 12,
  numberOfSeasons: 2,
  overview: 'Lorem ipsum',
  posterPath: '/2837289.jpg',
  status: 'Ongoing',
  voteAverage: 9.1,
  voteCount: 230,
  seasons: [testTvSeriesSeasonModel],
);

const testTvSeriesDetail = TvSeriesDetail(
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
  seasons: [testTvSeriesSeason],
);

const testWatchlistTvSeries = TvSeries.watchList(
  id: 1,
  name: 'Forever',
  overview: 'Lorem ipsum',
  posterPath: '/2837289.jpg',
);
