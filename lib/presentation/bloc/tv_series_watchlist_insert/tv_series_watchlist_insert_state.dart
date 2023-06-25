part of 'tv_series_watchlist_insert_bloc.dart';

abstract class TvSeriesWatchlistInsertState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistInsertInitial extends TvSeriesWatchlistInsertState {}

class TvSeriesWatchlistInsertLoading extends TvSeriesWatchlistInsertState {}

class TvSeriesWatchlistInsertFailure extends TvSeriesWatchlistInsertState {
  TvSeriesWatchlistInsertFailure(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class TvSeriesWatchlistInsertSuccess extends TvSeriesWatchlistInsertState {
  TvSeriesWatchlistInsertSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
