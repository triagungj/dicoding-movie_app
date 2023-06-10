import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchlistStatusTv {
  GetWatchlistStatusTv(this.repository);
  final TvSeriesRepository repository;

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
