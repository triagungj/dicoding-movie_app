part of 'movies_recommendation_bloc.dart';

abstract class MoviesRecommendationState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesRecommendationInitial extends MoviesRecommendationState {}

class MoviesRecommendationLoading extends MoviesRecommendationState {}

class MoviesRecommendationSuccess extends MoviesRecommendationState {
  MoviesRecommendationSuccess(this.results);

  final List<Movie> results;
  @override
  List<Object> get props => [results];
}

class MoviesRecommendationFailure extends MoviesRecommendationState {
  MoviesRecommendationFailure(this.message);

  final String message;
}
