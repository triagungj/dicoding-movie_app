import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.lastAirDate,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.posterPath,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json['adult'] as bool,
        backdropPath: json['backdrop_path'] as String,
        firstAirDate: json['first_air_date'] as String,
        genres: (json['genres'] as List)
            .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json['id'] as int,
        lastAirDate: json['last_air_date'] as String,
        name: json['name'] as String,
        numberOfEpisodes: json['number_of_episodes'] as int,
        numberOfSeasons: json['number_of_seasons'] as int,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String,
        status: json['status'] as String,
        voteAverage: json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
      );
  final int id;
  final bool adult;
  final String backdropPath;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String posterPath;
  final String status;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: id,
      adult: adult,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      lastAirDate: lastAirDate,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      overview: overview,
      posterPath: posterPath,
      status: status,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        adult,
        backdropPath,
        firstAirDate,
        genres,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        posterPath,
        status,
        voteAverage,
        voteCount,
      ];
}
