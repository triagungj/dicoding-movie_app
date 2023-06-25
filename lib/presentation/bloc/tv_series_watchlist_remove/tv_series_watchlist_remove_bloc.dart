import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';

part 'tv_series_watchlist_remove_event.dart';
part 'tv_series_watchlist_remove_state.dart';

class TvSeriesWatchlistRemoveBloc
    extends Bloc<TvSeriesWatchlistRemoveEvent, TvSeriesWatchlistRemoveState> {
  TvSeriesWatchlistRemoveBloc({
    required this.removeWatchlistTv,
  }) : super(TvSeriesWatchlistRemoveInitial()) {
    on<AddTvSeriesWatchlistRemoveEvent>((event, emit) async {
      emit(TvSeriesWatchlistRemoveLoading());

      final call = await removeWatchlistTv.execute(event.detail);

      call.fold(
        (l) => emit(TvSeriesWatchlistRemoveFailure(l.message)),
        (r) => emit(TvSeriesWatchlistRemoveSuccess(r)),
      );
    });
  }

  final RemoveWatchlistTv removeWatchlistTv;
}
