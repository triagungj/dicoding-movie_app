import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';

part 'tv_series_watchlist_insert_event.dart';
part 'tv_series_watchlist_insert_state.dart';

class TvSeriesWatchlistInsertBloc
    extends Bloc<TvSeriesWatchlistInsertEvent, TvSeriesWatchlistInsertState> {
  TvSeriesWatchlistInsertBloc({
    required this.saveWatchlistTv,
  }) : super(TvSeriesWatchlistInsertInitial()) {
    on<AddTvSeriesWatchlistInsertEvent>((event, emit) async {
      emit(TvSeriesWatchlistInsertLoading());

      final call = await saveWatchlistTv.execute(event.detail);

      call.fold(
        (l) => emit(TvSeriesWatchlistInsertFailure(l.message)),
        (r) => emit(TvSeriesWatchlistInsertSuccess(r)),
      );
    });
  }

  final SaveWatchlistTv saveWatchlistTv;
}
