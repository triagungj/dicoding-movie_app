import 'package:common/genre_model.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

class TvSeriesDetailResponse extends Equatable {
  const TvSeriesDetailResponse({
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    this.genres,
    this.adult,
    this.backdropPath,
    this.firstAirDate,
    this.lastAirDate,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.status,
    this.voteAverage,
    this.voteCount,
    this.seasons,
  });

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        adult: json['adult'] as bool,
        backdropPath: json['backdrop_path'] as String?,
        firstAirDate: json['first_air_date'] as String?,
        genres: json['genres'] != null
            ? (json['genres'] as List)
                .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
        id: json['id'] as int,
        lastAirDate: json['last_air_date'] as String?,
        name: json['name'] as String,
        numberOfEpisodes: json['number_of_episodes'] as int?,
        numberOfSeasons: json['number_of_seasons'] as int?,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String?,
        status: json['status'] as String?,
        voteAverage: json['vote_average'] as double?,
        voteCount: json['vote_count'] as int?,
        seasons: json['seasons'] != null
            ? (json['seasons'] as List)
                .map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );
  final int id;
  final String name;
  final String? posterPath;
  final String overview;
  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<GenreModel>? genres;
  final String? lastAirDate;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? status;
  final double? voteAverage;
  final int? voteCount;
  final List<SeasonModel>? seasons;

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: id,
      adult: adult,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres?.map((genre) => genre.toEntity()).toList(),
      lastAirDate: lastAirDate,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      overview: overview,
      posterPath: posterPath,
      status: status,
      voteAverage: voteAverage,
      voteCount: voteCount,
      seasons: seasons?.map((seasons) => seasons.toEntity()).toList(),
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
