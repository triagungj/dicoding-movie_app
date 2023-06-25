part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieWatchlistStatusEvent extends MovieWatchlistStatusEvent {
  GetMovieWatchlistStatusEvent(this.id);

  final int id;

  @override
  List<Object> get props => [];
}
