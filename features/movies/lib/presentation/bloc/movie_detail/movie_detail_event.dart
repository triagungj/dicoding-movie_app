part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  GetMovieDetailEvent(this.id);

  final int id;
}
