import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  const TvSeriesModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.firstAirDate,
    required this.genreIds,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.posterPath,
    this.backdropPath,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        backdropPath: json['backdrop_path'] as String?,
        firstAirDate: json['first_air_date'] as String,
        genreIds: List<int>.from(
          (json['genre_ids'] as List).map((x) => x),
        ),
        id: json['id'] as int,
        name: json['name'] as String,
        originCountry: List<String>.from(
          (json['origin_country'] as List).map((x) => x),
        ),
        originalLanguage: json['original_language'] as String,
        originalName: json['original_name'] as String,
        overview: json['overview'] as String,
        popularity: json['popularity'] as double,
        posterPath: json['poster_path'] as String?,
        voteAverage: json['vote_average'] is String
            ? double.parse(json['vote_average'] as String)
            : json['vote_average'] is int
                ? (json['vote_average'] as int).toDouble()
                : json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
      );
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String firstAirDate;
  final List<int> genreIds;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String? backdropPath;

  TvSeries toEntity() {
    return TvSeries(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      backdropPath: backdropPath,
    );
  }

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'first_air_date': firstAirDate,
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'id': id,
        'name': name,
        'origin_country': List<dynamic>.from(originCountry.map((x) => x)),
        'original_language': originalLanguage,
        'original_name': originalName,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        firstAirDate,
        genreIds,
        originCountry,
        originalLanguage,
        originalName,
        popularity,
        voteAverage,
        voteCount,
        backdropPath,
      ];
}