part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesSearchInitial extends TvSeriesSearchState {}

class TvSeriesSearchLoading extends TvSeriesSearchState {}

class TvSeriesSearchFailure extends TvSeriesSearchState {
  TvSeriesSearchFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class TvSeriesSearchSuccess extends TvSeriesSearchState {
  TvSeriesSearchSuccess(this.results);

  final List<TvSeries> results;

  @override
  List<Object> get props => [results];
}
