import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieDetailResponse extends Equatable {
  const MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        adult: json['adult'] as bool,
        backdropPath: json['backdrop_path'] as String,
        budget: json['budget'] as int,
        genres: (json['genres'] as List)
            .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        // List<GenreModel>.from(
        //   (json['genres'] as List).map(GenreModel.fromJson),
        // ),
        homepage: json['homepage'] as String,
        id: json['id'] as int,
        imdbId: json['imdb_id'] as String,
        originalLanguage: json['original_language'] as String,
        originalTitle: json['original_title'] as String,
        overview: json['overview'] as String,
        popularity: json['popularity'] as double,
        posterPath: json['poster_path'] as String,
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
  final String posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'budget': budget,
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
        'homepage': homepage,
        'id': id,
        'imdb_id': imdbId,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'revenue': revenue,
        'runtime': runtime,
        'status': status,
        'tagline': tagline,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

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
