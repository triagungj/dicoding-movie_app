import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTvDetail(repository);
  });

  const tvId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(repository.getTvSeriesDetail(tvId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));
    // act
    final result = await usecase.execute(tvId);
    // assert
    expect(result, const Right<dynamic, TvSeriesDetail>(testTvSeriesDetail));
  });
}
