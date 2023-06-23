import 'package:dependencies/equatable/equatable.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';

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
