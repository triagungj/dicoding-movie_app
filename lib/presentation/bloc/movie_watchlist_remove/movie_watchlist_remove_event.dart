part of 'movie_watchlist_remove_bloc.dart';

abstract class MovieWatchlistRemoveEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddMovieWatchlistRemoveEvent extends MovieWatchlistRemoveEvent {
  AddMovieWatchlistRemoveEvent(this.movieDetail);

  final MovieDetail movieDetail;
  @override
  List<Object> get props => [movieDetail];
}
