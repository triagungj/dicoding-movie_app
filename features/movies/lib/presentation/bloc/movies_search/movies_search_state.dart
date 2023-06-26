part of 'movies_search_bloc.dart';

abstract class MoviesSearchState {}

class MoviesSearchInitial extends MoviesSearchState {}

class MoviesSearchLoading extends MoviesSearchState {}

class MoviesSearchSuccess extends MoviesSearchState {
  MoviesSearchSuccess(this.result);

  final List<Movie> result;
}

class MoviesSearchFailure extends MoviesSearchState {
  MoviesSearchFailure(this.message);

  final String message;
}
