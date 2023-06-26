import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_top_rated.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  TvSeriesTopRatedBloc({
    required this.getTvTopRated,
  }) : super(TvSeriesTopRatedInitial()) {
    on<GetTvSeriesTopRatedEvent>((event, emit) async {
      emit(TvSeriesTopRatedLoading());

      final call = await getTvTopRated.execute();

      call.fold(
        (l) => emit(TvSeriesTopRatedFailure(l.message)),
        (r) => emit(TvSeriesTopRatedSuccess(r)),
      );
    });
  }

  final GetTvTopRated getTvTopRated;
}
