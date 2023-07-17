import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class MockTvSeriesAiringTodayBloc
    extends MockBloc<TvSeriesAiringTodayEvent, TvSeriesAiringTodayState>
    implements TvSeriesAiringTodayBloc {}

class MockTvSeriesPopularBloc
    extends MockBloc<TvSeriesPopularEvent, TvSeriesPopularState>
    implements TvSeriesPopularBloc {}

class MockTvSeriesRecommendationsBloc
    extends MockBloc<TvSeriesRecommendationsEvent, TvSeriesRecommendationsState>
    implements TvSeriesRecommendationsBloc {}

class MockTvSeriesSearchBloc
    extends MockBloc<TvSeriesSearchEvent, TvSeriesSearchState>
    implements TvSeriesSearchBloc {}

class MockTvSeriesTopRatedBloc
    extends MockBloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState>
    implements TvSeriesTopRatedBloc {}

class MockTvSeriesWatchlistInsertBloc
    extends MockBloc<TvSeriesWatchlistInsertEvent, TvSeriesWatchlistInsertState>
    implements TvSeriesWatchlistInsertBloc {}

class MockTvSeriesWatchlistLoadBloc
    extends MockBloc<TvSeriesWatchlistLoadEvent, TvSeriesWatchlistLoadState>
    implements TvSeriesWatchlistLoadBloc {}

class MockTvSeriesWatchlistRemoveBloc
    extends MockBloc<TvSeriesWatchlistRemoveEvent, TvSeriesWatchlistRemoveState>
    implements TvSeriesWatchlistRemoveBloc {}

class MockTvSeriesWatchlistStatusBloc
    extends MockBloc<TvSeriesWatchlistStatusEvent, bool>
    implements TvSeriesWatchlistStatusBloc {}
