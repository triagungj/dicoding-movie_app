part of 'tv_series_watchlist_remove_bloc.dart';

abstract class TvSeriesWatchlistRemoveState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistRemoveInitial extends TvSeriesWatchlistRemoveState {}

class TvSeriesWatchlistRemoveLoading extends TvSeriesWatchlistRemoveState {}

class TvSeriesWatchlistRemoveFailure extends TvSeriesWatchlistRemoveState {
  TvSeriesWatchlistRemoveFailure(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistRemoveSuccess extends TvSeriesWatchlistRemoveState {
  TvSeriesWatchlistRemoveSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
