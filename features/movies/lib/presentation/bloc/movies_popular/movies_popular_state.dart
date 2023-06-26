part of 'movies_popular_bloc.dart';

abstract class MoviesPopularState {}

class MoviesPopularInitial extends MoviesPopularState {}

class MoviesPopularLoading extends MoviesPopularState {}

class MoviesPopularSuccess extends MoviesPopularState {
  MoviesPopularSuccess(this.result);

  final List<Movie> result;
}

class MoviesPopularFailure extends MoviesPopularState {
  MoviesPopularFailure(this.message);

  final String message;
}
