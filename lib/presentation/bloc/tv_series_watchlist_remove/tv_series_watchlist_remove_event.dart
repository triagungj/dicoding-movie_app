part of 'tv_series_watchlist_remove_bloc.dart';

abstract class TvSeriesWatchlistRemoveEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTvSeriesWatchlistRemoveEvent extends TvSeriesWatchlistRemoveEvent {
  AddTvSeriesWatchlistRemoveEvent(this.detail);

  final TvSeriesDetail detail;
}
