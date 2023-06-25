part of 'movies_now_playing_bloc.dart';

abstract class MoviesNowPlayingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoviesNowPlayingInitial extends MoviesNowPlayingState {}

class MoviesNowPlayingLoading extends MoviesNowPlayingState {}

class MoviesNowPlayingSuccess extends MoviesNowPlayingState {
  MoviesNowPlayingSuccess(this.result);

  final List<Movie> result;

  @override
  List<Object?> get props => [result];
}

class MoviesNowPlayingFailure extends MoviesNowPlayingState {
  MoviesNowPlayingFailure(this.message);

  final String message;
  @override
  List<Object?> get props => [message];
}
