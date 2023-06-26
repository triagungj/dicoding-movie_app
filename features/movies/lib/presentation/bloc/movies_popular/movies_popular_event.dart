part of 'movies_popular_bloc.dart';

abstract class MoviesPopularEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMoviesPopularEvent extends MoviesPopularEvent {}
