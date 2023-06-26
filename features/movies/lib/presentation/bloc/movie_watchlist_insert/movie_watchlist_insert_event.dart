part of 'movie_watchlist_insert_bloc.dart';

abstract class MovieWatchlistInsertEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddMovieWatchlistInsertEvent extends MovieWatchlistInsertEvent {
  AddMovieWatchlistInsertEvent(this.movieDetail);

  final MovieDetail movieDetail;
}
