import 'package:dependencies/equatable/equatable.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';

part 'tv_series_watchlist_status_event.dart';

class TvSeriesWatchlistStatusBloc
    extends Bloc<TvSeriesWatchlistStatusEvent, bool> {
  TvSeriesWatchlistStatusBloc({
    required this.getWatchlistStatusTv,
  }) : super(false) {
    on<GetTvSeriesWatchlistStatusEvent>((event, emit) async {
      emit(false);

      final result = await getWatchlistStatusTv.execute(event.id);

      emit(result);
    });
  }

  final GetWatchlistStatusTv getWatchlistStatusTv;
}