part of 'movies_recommendation_bloc.dart';

abstract class MoviesRecommendationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMoviesRecommendationEvent extends MoviesRecommendationEvent {
  GetMoviesRecommendationEvent(this.id);

  final int id;
}
