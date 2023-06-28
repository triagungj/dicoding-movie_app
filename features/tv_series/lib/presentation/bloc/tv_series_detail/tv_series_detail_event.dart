part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent {}

class GetTvSeriesDetailEvent extends TvSeriesDetailEvent {
  GetTvSeriesDetailEvent(this.id);

  final int id;
}
