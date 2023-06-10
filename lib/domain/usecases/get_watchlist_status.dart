import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetWatchListStatus {
  GetWatchListStatus(this.repository);
  final MovieRepository repository;

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
