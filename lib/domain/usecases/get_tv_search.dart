import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSearch {
  GetTvSearch(this.repository);
  final TvSeriesRepository repository;

  Future<Either<Failure, List<TvSeries>>> execute(String query) async {
    return repository.searchTvSeries(query);
  }
}
