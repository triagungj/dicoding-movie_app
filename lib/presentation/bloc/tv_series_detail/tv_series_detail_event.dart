part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTvSeriesDetailEvent extends TvSeriesDetailEvent {
  GetTvSeriesDetailEvent(this.id);

  final int id;

  @override
  List<Object> get props => [];
}
