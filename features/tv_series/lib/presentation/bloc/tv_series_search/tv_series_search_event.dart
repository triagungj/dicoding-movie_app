part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTvSeriesSearchEvent extends TvSeriesSearchEvent {
  GetTvSeriesSearchEvent(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}
