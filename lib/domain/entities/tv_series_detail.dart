import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
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
  final int id;
  final bool adult;
  final String backdropPath;
  final String firstAirDate;
  final List<Genre> genres;
  final String lastAirDate;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String posterPath;
  final String status;
  final double voteAverage;
  final int voteCount;

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
