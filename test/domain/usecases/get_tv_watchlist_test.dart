import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetWatchlistTv(repository);
  });

  test('should get list of watchlist tv series from the repository', () async {
    // arrange
    when(repository.getWatchlistTvSeries())
        .thenAnswer((_) async => const Right([testTvSeries]));
    // act
    final result = await usecase.execute();
    // assert
    expect(
      result,
      const Right<dynamic, List<TvSeries>>([testTvSeries]),
    );
  });
}
