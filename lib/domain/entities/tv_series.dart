import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  const TvSeries({
    required this.id,
    required this.name,
    required this.firstAirDate,
    required this.genreIds,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.overview,
    this.posterPath,
    this.backdropPath,
  });

  const TvSeries.watchList({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.popularity,
    this.voteAverage,
    this.voteCount,
  });
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        backdropPath,
        firstAirDate,
        genreIds,
        originCountry,
        originalLanguage,
        originalName,
        popularity,
        voteAverage,
        voteCount,
      ];
}
