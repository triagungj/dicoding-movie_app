import 'package:flutter_test/flutter_test.dart';
import 'package:movies/data/models/movie_model.dart';
import 'package:movies/domain/entities/movie.dart';

void main() {
  test('should be a subclass of Movie entity', () async {
    const tMovieModel = MovieModel(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    const tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });

  test('should be return Movie entity even if some data is empty', () async {
    const map1 = {
      'adult': false,
      'backdrop_path': 'backdropPath',
      'genre_ids': null,
      'id': 1,
      'original_title': 'originalTitle',
      'overview': 'overview',
      'popularity': 1.0,
      'poster_path': 'posterPath',
      'release_date': 'releaseDate',
      'title': 'title',
      'video': false,
      'vote_average': '1',
      'vote_count': 1,
    };
    const map2 = {
      'adult': false,
      'backdrop_path': 'backdropPath',
      'genre_ids': null,
      'id': 1,
      'original_title': 'originalTitle',
      'overview': 'overview',
      'popularity': 1.0,
      'poster_path': 'posterPath',
      'release_date': 'releaseDate',
      'title': 'title',
      'video': false,
      'vote_average': 1,
      'vote_count': 1,
    };

    const tMovieModel = MovieModel(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    final result1 = MovieModel.fromJson(map1);
    final result2 = MovieModel.fromJson(map2);
    expect(result1, tMovieModel);
    expect(result2, tMovieModel);
  });
}
