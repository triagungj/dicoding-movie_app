import 'package:dependencies/dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvAiringToday usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvAiringToday(mockRepository);
  });
  final tvSeries = <TvSeries>[];

  test(
    'should return list of airing today Tv Series',
    () async {
      // arrange
      when(mockRepository.getAiringTodayTvSeries()).thenAnswer(
        (realInvocation) async => Right(tvSeries),
      );
      // act
      final result = await usecase.execute();

      // assert
      expect(result, Right<dynamic, List<TvSeries>>(tvSeries));
    },
  );
}
