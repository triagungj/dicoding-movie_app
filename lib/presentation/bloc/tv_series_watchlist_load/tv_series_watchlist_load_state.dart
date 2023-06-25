part of 'tv_series_watchlist_load_bloc.dart';

abstract class TvSeriesWatchlistLoadState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistLoadInitial extends TvSeriesWatchlistLoadState {}

class TvSeriesWatchlistLoadLoading extends TvSeriesWatchlistLoadState {}

class TvSeriesWatchlistLoadFailure extends TvSeriesWatchlistLoadState {
  TvSeriesWatchlistLoadFailure(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistLoadSuccess extends TvSeriesWatchlistLoadState {
  TvSeriesWatchlistLoadSuccess(this.results);

  final List<TvSeries> results;

  @override
  List<Object> get props => [results];
}
