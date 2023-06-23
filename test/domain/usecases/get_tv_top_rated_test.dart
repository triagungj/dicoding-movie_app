import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvTopRated usecase;
  late MockTvSeriesRepository mockRepo;

  setUp(() {
    mockRepo = MockTvSeriesRepository();
    usecase = GetTvTopRated(mockRepo);
  });

  final topRatedList = <TvSeries>[];

  test(
    'should get list of tv series from the repository',
    () async {
      // arrange
      when(mockRepo.getTopRatedTvSeries()).thenAnswer(
        (_) async => Right(topRatedList),
      );

      // act
      final result = await usecase.execute();

      // assert
      expect(result, Right<dynamic, List<TvSeries>>(topRatedList));
    },
  );
}
