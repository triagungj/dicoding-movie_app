import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetTvTopRated {
  GetTvTopRated(this.repository);
  final TvSeriesRepository repository;

  Future<Either<Failure, List<TvSeries>>> execute() async {
    return repository.getTopRatedTvSeries();
  }
}
