part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailSuccess extends MovieDetailState {
  MovieDetailSuccess(this.result);

  final MovieDetail result;

  @override
  List<Object> get props => [result];
}

class MovieDetailFailure extends MovieDetailState {
  MovieDetailFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
