part of 'movies_now_playing_bloc.dart';

abstract class MoviesNowPlayingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNowPlayingMoviesEvent extends MoviesNowPlayingEvent {}
