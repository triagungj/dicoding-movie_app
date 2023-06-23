import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvSeriesRepository mockRepo;

  setUp(() {
    mockRepo = MockTvSeriesRepository();
    usecase = RemoveWatchlistTv(mockRepo);
  });

  test(
    'should save tv series to the repository',
    () async {
      // arrange
      when(mockRepo.removeWatchlist(testTvSeriesDetail)).thenAnswer(
        (_) async => const Right('Removed from watchlist'),
      );
      // act
      final result = await usecase.execute(testTvSeriesDetail);
      // assert
      verify(mockRepo.removeWatchlist(testTvSeriesDetail));
      expect(result, const Right<dynamic, String>('Removed from watchlist'));
    },
  );
}
