part of 'movies_search_bloc.dart';

abstract class MoviesSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMoviesSearchEvent extends MoviesSearchEvent {
  GetMoviesSearchEvent(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}
