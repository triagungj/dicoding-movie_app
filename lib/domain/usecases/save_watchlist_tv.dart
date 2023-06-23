import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SaveWatchlistTv {
  SaveWatchlistTv(this.repository);
  final TvSeriesRepository repository;

  Future<Either<Failure, String>> execute(TvSeriesDetail detail) {
    return repository.saveWatchlist(detail);
  }
}
