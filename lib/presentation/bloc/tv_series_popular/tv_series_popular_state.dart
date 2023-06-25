part of 'tv_series_popular_bloc.dart';

abstract class TvSeriesPopularState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesPopularInitial extends TvSeriesPopularState {}

class TvSeriesPopularLoading extends TvSeriesPopularState {}

class TvSeriesPopularFailure extends TvSeriesPopularState {
  TvSeriesPopularFailure(this.message);

  final String message;
}

class TvSeriesPopularSuccess extends TvSeriesPopularState {
  TvSeriesPopularSuccess(this.results);

  final List<TvSeries> results;
  @override
  List<Object> get props => [results];
}
