part of 'movies_search_bloc.dart';

abstract class MoviesSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoviesSearchInitial extends MoviesSearchState {}

class MoviesSearchLoading extends MoviesSearchState {}

class MoviesSearchSuccess extends MoviesSearchState {
  MoviesSearchSuccess(this.result);

  final List<Movie> result;

  @override
  List<Object?> get props => [result];
}

class MoviesSearchFailure extends MoviesSearchState {
  MoviesSearchFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
