import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_search.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSearch usecase;
  late MockTvSeriesRepository mockRepo;

  setUp(() {
    mockRepo = MockTvSeriesRepository();
    usecase = GetTvSearch(mockRepo);
  });

  const query = 'forever';
  final searchList = <TvSeries>[];

  test(
    'should get list of tv series from the repository',
    () async {
      // arrange
      when(mockRepo.searchTvSeries(query)).thenAnswer(
        (_) async => Right(searchList),
      );

      // act
      final result = await usecase.execute(query);

      // assert
      expect(result, Right<dynamic, List<TvSeries>>(searchList));
    },
  );
}
