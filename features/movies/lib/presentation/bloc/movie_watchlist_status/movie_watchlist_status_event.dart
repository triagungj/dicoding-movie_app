part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusEvent {}

class GetMovieWatchlistStatusEvent extends MovieWatchlistStatusEvent {
  GetMovieWatchlistStatusEvent(this.id);

  final int id;
}
