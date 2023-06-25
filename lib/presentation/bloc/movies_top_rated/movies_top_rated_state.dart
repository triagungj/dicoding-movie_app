part of 'movies_top_rated_bloc.dart';

abstract class MoviesTopRatedState {}

class MoviesTopRatedInitial extends MoviesTopRatedState {}

class MoviesTopRatedLoading extends MoviesTopRatedState {}

class MoviesTopRatedSuccess extends MoviesTopRatedState {
  MoviesTopRatedSuccess(this.result);

  final List<Movie> result;
}

class MoviesTopRatedFailure extends MoviesTopRatedState {
  MoviesTopRatedFailure(this.message);

  final String message;
}
