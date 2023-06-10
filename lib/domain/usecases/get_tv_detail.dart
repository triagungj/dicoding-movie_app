import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvDetail {
  GetTvDetail(this.repository);
  final TvSeriesRepository repository;

  Future<Either<Failure, TvSeriesDetail>> execute(int id) async {
    return repository.getTvSeriesDetail(id);
  }
}
