part of 'movie_watchlist_remove_bloc.dart';

abstract class MovieWatchlistRemoveEvent {}

class AddMovieWatchlistRemoveEvent extends MovieWatchlistRemoveEvent {
  AddMovieWatchlistRemoveEvent(this.movieDetail);

  final MovieDetail movieDetail;
}
