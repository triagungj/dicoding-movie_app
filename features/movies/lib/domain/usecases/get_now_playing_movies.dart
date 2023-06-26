import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class GetNowPlayingMovies {
  GetNowPlayingMovies(this.repository);
  final MovieRepository repository;

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
