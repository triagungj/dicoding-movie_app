part of 'tv_series_airing_today_bloc.dart';

abstract class TvSeriesAiringTodayState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesAiringTodayInitial extends TvSeriesAiringTodayState {}

class TvSeriesAiringTodayLoading extends TvSeriesAiringTodayState {}

class TvSeriesAiringTodayFailure extends TvSeriesAiringTodayState {
  TvSeriesAiringTodayFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TvSeriesAiringTodaySuccess extends TvSeriesAiringTodayState {
  TvSeriesAiringTodaySuccess(this.results);

  final List<TvSeries> results;

  @override
  List<Object> get props => [results];
}
