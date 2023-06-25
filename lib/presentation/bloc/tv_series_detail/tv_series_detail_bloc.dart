import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  TvSeriesDetailBloc({
    required this.getTvDetail,
  }) : super(TvSeriesDetailInitial()) {
    on<GetTvSeriesDetailEvent>((event, emit) async {
      emit(TvSeriesDetailLoading());

      final call = await getTvDetail.execute(event.id);

      call.fold(
        (l) => emit(TvSeriesDetailFailure(l.message)),
        (r) => emit(TvSeriesDetailSuccess(r)),
      );
    });
  }

  final GetTvDetail getTvDetail;
}
