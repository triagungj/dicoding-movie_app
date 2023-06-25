import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';

part 'tv_series_airing_today_event.dart';
part 'tv_series_airing_today_state.dart';

class TvSeriesAiringTodayBloc
    extends Bloc<TvSeriesAiringTodayEvent, TvSeriesAiringTodayState> {
  TvSeriesAiringTodayBloc({
    required this.getTvAiringToday,
  }) : super(TvSeriesAiringTodayInitial()) {
    on<GetTvSeriesAiringTodayEvent>((event, emit) async {
      emit(TvSeriesAiringTodayLoading());

      final call = await getTvAiringToday.execute();

      call.fold(
        (l) => emit(TvSeriesAiringTodayFailure(l.message)),
        (r) => emit(TvSeriesAiringTodaySuccess(r)),
      );
    });
  }

  final GetTvAiringToday getTvAiringToday;
}
