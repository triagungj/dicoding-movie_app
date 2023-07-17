import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movies_bloc.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class GetMovieDetailEventFake extends Fake implements GetMovieDetailEvent {}

class MockMoviesRecommendationBloc
    extends MockBloc<MoviesRecommendationEvent, MoviesRecommendationState>
    implements MoviesRecommendationBloc {}

class MoviesRecommendationStateFake extends Fake
    implements MoviesRecommendationState {}

class MoviesRecommendationEventFake extends Fake
    implements MoviesRecommendationEvent {}

class MockMovieWatchlistInsertBloc
    extends MockBloc<MovieWatchlistInsertEvent, MovieWatchlistInsertState>
    implements MovieWatchlistInsertBloc {}

class MovieWatchlistInsertStateFake extends Fake
    implements MovieWatchlistInsertState {}

class MovieWatchlistInsertEventFake extends Fake
    implements MovieWatchlistInsertEvent {}

class MockMovieWatchlistLoadBloc
    extends MockBloc<MovieWatchlistLoadEvent, MovieWatchlistLoadState>
    implements MovieWatchlistLoadBloc {}

class MovieWatchlistLoadStateFake extends Fake
    implements MovieWatchlistLoadState {}

class MovieWatchlistLoadEventFake extends Fake
    implements MovieWatchlistLoadEvent {}

class MockMovieWatchlistRemoveBloc
    extends MockBloc<MovieWatchlistRemoveEvent, MovieWatchlistRemoveState>
    implements MovieWatchlistRemoveBloc {}

class MovieWatchlistRemoveStateFake extends Fake
    implements MovieWatchlistRemoveState {}

class MovieWatchlistRemoveEventFake extends Fake
    implements MovieWatchlistRemoveEvent {}

class MockMovieWatchlistStatusBloc
    extends MockBloc<MovieWatchlistStatusEvent, bool>
    implements MovieWatchlistStatusBloc {}

class MovieWatchlistStatusEventFake extends Fake
    implements MovieWatchlistStatusEvent {}

class MockMoviesNowPlayingBloc
    extends MockBloc<MoviesNowPlayingEvent, MoviesNowPlayingState>
    implements MoviesNowPlayingBloc {}

class MoviesNowPlayingStateFake extends Fake implements MoviesNowPlayingState {}

class MoviesNowPlayingEventFake extends Fake implements MoviesNowPlayingEvent {}

class MockMoviesPopularBloc
    extends MockBloc<MoviesPopularEvent, MoviesPopularState>
    implements MoviesPopularBloc {}

class MoviesPopularStateFake extends Fake implements MoviesPopularState {}

class MoviesPopularEventFake extends Fake implements MoviesPopularEvent {}

class MockMoviesSearchBloc
    extends MockBloc<MoviesSearchEvent, MoviesSearchState>
    implements MoviesSearchBloc {}

class MoviesSearchStateFake extends Fake implements MoviesSearchState {}

class MoviesSearchEventFake extends Fake implements MoviesSearchEvent {}

class MockMoviesTopRatedBloc
    extends MockBloc<MoviesTopRatedEvent, MoviesTopRatedState>
    implements MoviesTopRatedBloc {}

class MoviesTopRatedStateFake extends Fake implements MoviesTopRatedState {}

class MoviesTopRatedEventFake extends Fake implements MoviesTopRatedEvent {}
