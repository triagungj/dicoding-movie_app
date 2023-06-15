import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.firstAirDate,
    this.genres,
    this.lastAirDate,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.status,
    this.voteAverage,
    this.voteCount,
    this.seasons,
  });
  final int id;
  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? lastAirDate;
  final String name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String overview;
  final String? posterPath;
  final String? status;
  final double? voteAverage;
  final int? voteCount;
  final List<Season>? seasons;

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
        seasons,
      ];
}

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.episodeCount,
    this.posterPath,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        seasonNumber,
        episodeCount, 
        posterPath,
      ];
}
