part of 'movies_search_bloc.dart';

abstract class MoviesSearchEvent {}

class GetMoviesSearchEvent extends MoviesSearchEvent {
  GetMoviesSearchEvent(this.query);

  final String query;
}
