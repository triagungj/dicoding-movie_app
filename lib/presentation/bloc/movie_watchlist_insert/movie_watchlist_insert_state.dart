part of 'movie_watchlist_insert_bloc.dart';

abstract class MovieWatchlistInsertState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieWatchlistInsertInitial extends MovieWatchlistInsertState {}

class MovieWatchlistInsertLoading extends MovieWatchlistInsertState {}

class MovieWatchlistInsertFailure extends MovieWatchlistInsertState {
  MovieWatchlistInsertFailure(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class MovieWatchlistInsertSuccess extends MovieWatchlistInsertState {
  MovieWatchlistInsertSuccess(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}
