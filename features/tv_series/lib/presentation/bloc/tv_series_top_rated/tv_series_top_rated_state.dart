part of 'tv_series_top_rated_bloc.dart';

abstract class TvSeriesTopRatedState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesTopRatedInitial extends TvSeriesTopRatedState {}

class TvSeriesTopRatedLoading extends TvSeriesTopRatedState {}

class TvSeriesTopRatedFailure extends TvSeriesTopRatedState {
  TvSeriesTopRatedFailure(this.message);

  final String message;
}

class TvSeriesTopRatedSuccess extends TvSeriesTopRatedState {
  TvSeriesTopRatedSuccess(this.results);

  final List<TvSeries> results;
  @override
  List<Object> get props => [results];
}
