part of 'tv_series_watchlist_remove_bloc.dart';

abstract class TvSeriesWatchlistRemoveEvent {}

class AddTvSeriesWatchlistRemoveEvent extends TvSeriesWatchlistRemoveEvent {
  AddTvSeriesWatchlistRemoveEvent(this.detail);

  final TvSeriesDetail detail;
}
