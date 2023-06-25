part of 'tv_series_recommendations_bloc.dart';

abstract class TvSeriesRecommendationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTvSeriesRecommendationsEvent extends TvSeriesRecommendationsEvent {
  GetTvSeriesRecommendationsEvent(this.id);

  final int id;

  @override
  List<Object> get props => [];
}
