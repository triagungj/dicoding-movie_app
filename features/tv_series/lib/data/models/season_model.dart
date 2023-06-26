import 'package:dependencies/equatable/equatable.dart';
import 'package:tv_series/domain/entities/season.dart';

class SeasonModel extends Equatable {
  const SeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.episodeCount,
    this.posterPath,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        id: json['id'] as int,
        name: json['name'] as String,
        overview: json['overview'] as String,
        seasonNumber: json['id'] as int,
        posterPath: json['poster_path'] as String?,
        episodeCount: json['episode_count'] as int,
      );

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int episodeCount;

  Season toEntity() {
    return Season(
      id: id,
      name: name,
      overview: overview,
      seasonNumber: seasonNumber,
      posterPath: posterPath,
      episodeCount: episodeCount,
    );
  }

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
