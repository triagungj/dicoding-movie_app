part of 'movie_watchlist_insert_bloc.dart';

abstract class MovieWatchlistInsertEvent {}

class AddMovieWatchlistInsertEvent extends MovieWatchlistInsertEvent {
  AddMovieWatchlistInsertEvent(this.movieDetail);

  final MovieDetail movieDetail;
}
