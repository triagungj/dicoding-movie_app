part of 'tv_series_recommendations_bloc.dart';

abstract class TvSeriesRecommendationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationsInitial extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsLoading extends TvSeriesRecommendationsState {}

class TvSeriesRecommendationsFailure extends TvSeriesRecommendationsState {
  TvSeriesRecommendationsFailure(this.message);

  final String message;
}

class TvSeriesRecommendationsSuccess extends TvSeriesRecommendationsState {
  TvSeriesRecommendationsSuccess(this.results);

  final List<TvSeries> results;

  @override
  List<Object> get props => [results];
}
