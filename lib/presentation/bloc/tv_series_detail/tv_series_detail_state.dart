part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailFailure extends TvSeriesDetailState {
  TvSeriesDetailFailure(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}

class TvSeriesDetailSuccess extends TvSeriesDetailState {
  TvSeriesDetailSuccess(this.result);

  final TvSeriesDetail result;
  @override
  List<Object> get props => [result];
}
