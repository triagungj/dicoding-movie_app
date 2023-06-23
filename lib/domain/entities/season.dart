import 'package:dependencies/equatable/equatable.dart';

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
