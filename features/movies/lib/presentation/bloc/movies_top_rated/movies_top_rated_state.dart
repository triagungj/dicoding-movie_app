part of 'movies_top_rated_bloc.dart';

abstract class MoviesTopRatedState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesTopRatedInitial extends MoviesTopRatedState {}

class MoviesTopRatedLoading extends MoviesTopRatedState {}

class MoviesTopRatedSuccess extends MoviesTopRatedState {
  MoviesTopRatedSuccess(this.result);

  final List<Movie> result;

  @override
  List<Object> get props => [result];
}

class MoviesTopRatedFailure extends MoviesTopRatedState {
  MoviesTopRatedFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
