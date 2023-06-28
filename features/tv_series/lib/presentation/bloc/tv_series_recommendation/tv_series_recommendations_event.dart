part of 'tv_series_recommendations_bloc.dart';

abstract class TvSeriesRecommendationsEvent {}

class GetTvSeriesRecommendationsEvent extends TvSeriesRecommendationsEvent {
  GetTvSeriesRecommendationsEvent(this.id);

  final int id;
}
