import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetTvDetail {
  GetTvDetail(this.repository);
  final TvSeriesRepository repository;

  Future<Either<Failure, TvSeriesDetail>> execute(int id) async {
    return repository.getTvSeriesDetail(id);
  }
}