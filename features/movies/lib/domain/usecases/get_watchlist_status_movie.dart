import 'package:movies/domain/repositories/movie_repository.dart';

class GetWatchListStatusMovie {
  GetWatchListStatusMovie(this.repository);
  final MovieRepository repository;

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
