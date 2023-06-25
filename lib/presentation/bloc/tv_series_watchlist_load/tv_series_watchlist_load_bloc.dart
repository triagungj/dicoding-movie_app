import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';

part 'tv_series_watchlist_load_event.dart';
part 'tv_series_watchlist_load_state.dart';

class TvSeriesWatchlistLoadBloc
    extends Bloc<TvSeriesWatchlistLoadEvent, TvSeriesWatchlistLoadState> {
  TvSeriesWatchlistLoadBloc({
    required this.getWatchlistTv,
  }) : super(TvSeriesWatchlistLoadInitial()) {
    on<GetTvSeriesWatchlistLoadEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoadLoading());

      final call = await getWatchlistTv.execute();

      call.fold(
        (l) => emit(TvSeriesWatchlistLoadFailure(l.message)),
        (r) => emit(TvSeriesWatchlistLoadSuccess(r)),
      );
    });
  }

  final GetWatchlistTv getWatchlistTv;
}
