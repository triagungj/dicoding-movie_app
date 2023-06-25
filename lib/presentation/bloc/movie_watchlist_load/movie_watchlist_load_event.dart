part of 'movie_watchlist_load_bloc.dart';

abstract class MovieWatchlistLoadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieWatchlistLoadEvent extends MovieWatchlistLoadEvent {}
