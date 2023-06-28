part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent {}

class GetTvSeriesSearchEvent extends TvSeriesSearchEvent {
  GetTvSeriesSearchEvent(this.query);

  final String query;
}
