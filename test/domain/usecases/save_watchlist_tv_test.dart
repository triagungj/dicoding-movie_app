import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvSeriesRepository mockRepo;

  setUp(() {
    mockRepo = MockTvSeriesRepository();
    usecase = SaveWatchlistTv(mockRepo);
  });

  test(
    'should save tv series to the repository',
    () async {
      // arrange
      when(mockRepo.saveWatchlist(testTvSeriesDetail)).thenAnswer(
        (_) async => const Right('Added to Watchlist'),
      );
      // act
      final result = await usecase.execute(testTvSeriesDetail);
      // assert
      verify(mockRepo.saveWatchlist(testTvSeriesDetail));
      expect(result, const Right<dynamic, String>('Added to Watchlist'));
    },
  );
}
