import 'package:common/genre_model.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';

class MovieDetailResponse extends Equatable {
  const MovieDetailResponse({
    required this.adult,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.imdbId,
    this.backdropPath,
    this.posterPath,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        adult: json['adult'] as bool,
        backdropPath: json['backdrop_path'] as String?,
        budget: json['budget'] as int,
        genres: (json['genres'] as List)
            .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        // List<GenreModel>.from(
        //   (json['genres'] as List).map(GenreModel.fromJson),
        // ),
        homepage: json['homepage'] as String,
        id: json['id'] as int,
        imdbId: json['imdb_id'] as String?,
        originalLanguage: json['original_language'] as String,
        originalTitle: json['original_title'] as String,
        overview: json['overview'] as String,
        popularity: json['popularity'] as double,
        posterPath: json['poster_path'] as String?,
        releaseDate: json['release_date'] as String,
        revenue: json['revenue'] as int,
        runtime: json['runtime'] as int,
        status: json['status'] as String,
        tagline: json['tagline'] as String,
        title: json['title'] as String,
        video: json['video'] as bool,
        voteAverage: json['vote_average'] as double,
        voteCount: json['vote_count'] as int,
      );

  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetail toEntity() {
    return MovieDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      runtime: runtime,
      title: title,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        budget,
        genres,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        revenue,
        runtime,
        status,
        tagline,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
