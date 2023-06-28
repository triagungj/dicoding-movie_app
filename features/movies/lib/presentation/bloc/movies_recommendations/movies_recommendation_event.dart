part of 'movies_recommendation_bloc.dart';

abstract class MoviesRecommendationEvent {}

class GetMoviesRecommendationEvent extends MoviesRecommendationEvent {
  GetMoviesRecommendationEvent(this.id);

  final int id;
}
