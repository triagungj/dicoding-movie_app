part of 'tv_series_watchlist_insert_bloc.dart';

abstract class TvSeriesWatchlistInsertEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTvSeriesWatchlistInsertEvent extends TvSeriesWatchlistInsertEvent {
  AddTvSeriesWatchlistInsertEvent(this.detail);

  final TvSeriesDetail detail;

  @override
  List<Object> get props => [detail];
}
