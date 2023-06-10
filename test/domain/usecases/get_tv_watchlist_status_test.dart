import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistStatusTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetWatchlistStatusTv(repository);
  });

  test('should get tv watchlist status from repository', () async {
    // arrange
    when(repository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
