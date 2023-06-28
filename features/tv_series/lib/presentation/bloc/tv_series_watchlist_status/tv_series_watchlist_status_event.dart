part of 'tv_series_watchlist_status_bloc.dart';

abstract class TvSeriesWatchlistStatusEvent {}

class GetTvSeriesWatchlistStatusEvent extends TvSeriesWatchlistStatusEvent {
  GetTvSeriesWatchlistStatusEvent(this.id);

  final int id;
}
