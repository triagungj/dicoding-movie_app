import 'package:dependencies/equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.backdropPath,
    this.posterPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json['adult'] as bool,
        backdropPath: json['backdrop_path'] as String?,
        genreIds: json['genre_ids'] != null
            ? (json['genre_ids'] as List).map((e) => e as int).toList()
            : [],
        id: json['id'] as int,
        originalTitle: json['original_title'] as String,
        overview: json['overview'] as String,
        popularity: json['popularity'] as double,
        posterPath: json['poster_path'] as String?,
        releaseDate: json['release_date'] as String,
        title: json['title'] as String,
        video: json['video'] as bool,
        voteAverage: json['vote_average'] is String
            ? double.parse(json['vote_average'] as String)
            : json['vote_average'] is int
                ? (json['vote_average'] as int).toDouble()
                : json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
      );

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'id': id,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  Movie toEntity() {
    return Movie(
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
