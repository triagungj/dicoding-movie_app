part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieDetailEvent extends MovieDetailEvent {
  GetMovieDetailEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
