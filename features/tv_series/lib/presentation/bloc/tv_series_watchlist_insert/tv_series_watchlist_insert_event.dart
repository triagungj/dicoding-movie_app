part of 'tv_series_watchlist_insert_bloc.dart';

abstract class TvSeriesWatchlistInsertEvent {}

class AddTvSeriesWatchlistInsertEvent extends TvSeriesWatchlistInsertEvent {
  AddTvSeriesWatchlistInsertEvent(this.detail);

  final TvSeriesDetail detail;
}
