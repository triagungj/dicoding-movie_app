import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvRecommendations {
  GetTvRecommendations(this.repository);
  final TvSeriesRepository repository;

  Future<Either<Failure, List<TvSeries>>> execute(int id) async {
    return repository.getTvSeriesRecommendations(id);
  }
}
