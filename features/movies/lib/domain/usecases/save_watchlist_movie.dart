import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class SaveWatchlistMovie {
  SaveWatchlistMovie(this.repository);
  final MovieRepository repository;

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
