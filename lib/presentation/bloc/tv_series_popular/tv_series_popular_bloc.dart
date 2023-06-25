import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  TvSeriesPopularBloc({
    required this.getTvPopular,
  }) : super(TvSeriesPopularInitial()) {
    on<GetTvSeriesPopularEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());

      final call = await getTvPopular.execute();

      call.fold(
        (l) => emit(TvSeriesPopularFailure(l.message)),
        (r) => emit(TvSeriesPopularSuccess(r)),
      );
    });
  }

  final GetTvPopular getTvPopular;
}
