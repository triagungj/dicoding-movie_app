part of 'movie_watchlist_load_bloc.dart';

abstract class MovieWatchlistLoadState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieWatchlistLoadInitial extends MovieWatchlistLoadState {}

class MovieWatchlistLoadLoading extends MovieWatchlistLoadState {}

class MovieWatchlistLoadFailure extends MovieWatchlistLoadState {
  MovieWatchlistLoadFailure(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class MovieWatchlistLoadSuccess extends MovieWatchlistLoadState {
  MovieWatchlistLoadSuccess(this.results);

  final List<Movie> results;
}
