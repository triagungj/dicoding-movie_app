part of 'movie_watchlist_remove_bloc.dart';

abstract class MovieWatchlistRemoveState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieWatchlistRemoveInitial extends MovieWatchlistRemoveState {}

class MovieWatchlistRemoveLoading extends MovieWatchlistRemoveState {}

class MovieWatchlistRemoveFailure extends MovieWatchlistRemoveState {
  MovieWatchlistRemoveFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class MovieWatchlistRemoveSuccess extends MovieWatchlistRemoveState {
  MovieWatchlistRemoveSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
