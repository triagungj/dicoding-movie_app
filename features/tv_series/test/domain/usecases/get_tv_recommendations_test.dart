import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvSeriesRepository mockRepo;

  setUp(() {
    mockRepo = MockTvSeriesRepository();
    usecase = GetTvRecommendations(mockRepo);
  });

  const tvId = 1;
  final recommendationList = <TvSeries>[];

  test(
    'should get list of tv series from the repository',
    () async {
      // arrange
      when(mockRepo.getTvSeriesRecommendations(tvId)).thenAnswer(
        (_) async => Right(recommendationList),
      );

      // act
      final result = await usecase.execute(tvId);

      // assert
      expect(result, Right<dynamic, List<TvSeries>>(recommendationList));
    },
  );
}
