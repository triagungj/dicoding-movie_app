import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetMovieRecommendations {
  GetMovieRecommendations(this.repository);
  final MovieRepository repository;

  Future<Either<Failure, List<Movie>>> execute(int id) {
    return repository.getMovieRecommendations(id);
  }
}
