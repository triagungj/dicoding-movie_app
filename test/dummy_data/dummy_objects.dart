import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

const testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      '''After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.''',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

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
  seasons: [],
);

const testWatchlistTvSeries = TvSeries.watchList(
  id: 1,
  name: 'Forever',
  overview: 'Lorem ipsum',
  posterPath: '/2837289.jpg',
);
