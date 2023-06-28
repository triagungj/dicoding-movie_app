import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dependencies/dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvSeriesDetailBloc bloc;
  late MockGetTvDetail mobkGetTvDetail;

  setUp(() {
    mobkGetTvDetail = MockGetTvDetail();

    bloc = TvSeriesDetailBloc(
      getTvDetail: mobkGetTvDetail,
    );
  });

  group('TV Series Detail', () {
    const tvId = 1;
    test('initialState should be initial state', () {
      expect(bloc.state, TvSeriesDetailInitial());
    });

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits loading and success when GetTvSeriesDetailEvent added.',
      build: () {
        when(mobkGetTvDetail.execute(tvId)).thenAnswer(
          (_) async => const Right(testTvSeriesDetail),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesDetailEvent(tvId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailLoading(),
        TvSeriesDetailSuccess(testTvSeriesDetail),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'emits loading and failed when GetTvSeriesDetailEvent added.',
      build: () {
        when(mobkGetTvDetail.execute(tvId)).thenAnswer(
          (_) async => const Left(ServerFailure('Error')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetTvSeriesDetailEvent(tvId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailLoading(),
        TvSeriesDetailFailure('Error'),
      ],
    );
  });
}
