part of 'movies_top_rated_bloc.dart';

abstract class MoviesTopRatedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMoviesTopRatedEvent extends MoviesTopRatedEvent {}
