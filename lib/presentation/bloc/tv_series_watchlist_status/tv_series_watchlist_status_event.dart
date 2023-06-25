part of 'tv_series_watchlist_status_bloc.dart';

abstract class TvSeriesWatchlistStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTvSeriesWatchlistStatusEvent extends TvSeriesWatchlistStatusEvent {
  GetTvSeriesWatchlistStatusEvent(this.id);

  final int id;
}
