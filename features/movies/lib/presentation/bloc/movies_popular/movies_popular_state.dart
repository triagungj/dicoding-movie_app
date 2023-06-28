part of 'movies_popular_bloc.dart';

abstract class MoviesPopularState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesPopularInitial extends MoviesPopularState {}

class MoviesPopularLoading extends MoviesPopularState {}

class MoviesPopularSuccess extends MoviesPopularState {
  MoviesPopularSuccess(this.result);

  final List<Movie> result;
  @override
  List<Object> get props => [result];
}

class MoviesPopularFailure extends MoviesPopularState {
  MoviesPopularFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
