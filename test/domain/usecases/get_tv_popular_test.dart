import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockTvSeriesRepository mockRepo;

  setUp(() {
    mockRepo = MockTvSeriesRepository();
    usecase = GetTvPopular(repository: mockRepo);
  });

  final popularList = <TvSeries>[];

  test(
    'should get list of popular tv series from the repository',
    () async {
      // arrange
      when(mockRepo.getPopularTvSeries()).thenAnswer(
        (_) async => Right(popularList),
      );

      // act
      final result = await usecase.execute();

      // assert
      expect(result, Right<dynamic, List<TvSeries>>(popularList));
    },
  );
}
