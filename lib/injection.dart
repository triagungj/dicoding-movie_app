import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/http/http.dart' as http;
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_search.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_insert/movie_watchlist_insert_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_load/movie_watchlist_load_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_remove/movie_watchlist_remove_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_now_playing/movies_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_popular/movies_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_recommendations/movies_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_search/movies_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_top_rated/movies_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_airing_today/tv_series_airing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_insert/tv_series_watchlist_insert_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_load/tv_series_watchlist_load_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_remove/tv_series_watchlist_remove_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_status/tv_series_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/cubit/drawer_cubit.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator
    // * MOVIES
    ..registerFactory(
      () => MoviesNowPlayingBloc(
        getNowPlayingMovies: locator(),
      ),
    )
    ..registerFactory(
      () => MovieDetailBloc(
        getMovieDetail: locator(),
      ),
    )
    ..registerFactory(() => MoviesPopularBloc(getPopularMovies: locator()))
    ..registerFactory(
      () => MoviesRecommendationBloc(getMovieRecommendations: locator()),
    )
    ..registerFactory(() => MoviesSearchBloc(searchMovies: locator()))
    ..registerFactory(() => MoviesTopRatedBloc(getTopRatedMovies: locator()))
    ..registerFactory(
      () => MovieWatchlistInsertBloc(saveWatchlistMovie: locator()),
    )
    ..registerFactory(
      () => MovieWatchlistLoadBloc(getWatchlistMovies: locator()),
    )
    ..registerFactory(
      () => MovieWatchlistRemoveBloc(removeWatchlistMovie: locator()),
    )
    ..registerFactory(
      () => MovieWatchlistStatusBloc(getWatchListStatusMovie: locator()),
    )

    // * TV SERIES
    ..registerFactory(
      () => TvSeriesAiringTodayBloc(getTvAiringToday: locator()),
    )
    ..registerFactory(
      () => TvSeriesPopularBloc(getTvPopular: locator()),
    )
    ..registerFactory(
      () => TvSeriesTopRatedBloc(getTvTopRated: locator()),
    )
    ..registerFactory(
      () => TvSeriesDetailBloc(getTvDetail: locator()),
    )
    ..registerFactory(
      () => TvSeriesRecommendationsBloc(getTvRecommendations: locator()),
    )
    ..registerFactory(() => TvSeriesSearchBloc(getTvSearch: locator()))
    ..registerFactory(
      () => TvSeriesWatchlistLoadBloc(getWatchlistTv: locator()),
    )
    ..registerFactory(
      () => TvSeriesWatchlistInsertBloc(saveWatchlistTv: locator()),
    )
    ..registerFactory(
      () => TvSeriesWatchlistStatusBloc(getWatchlistStatusTv: locator()),
    )
    ..registerFactory(
      () => TvSeriesWatchlistRemoveBloc(removeWatchlistTv: locator()),
    )
    // use case
    // * MOVIES
    ..registerLazySingleton(() => GetNowPlayingMovies(locator()))
    ..registerLazySingleton(() => GetPopularMovies(locator()))
    ..registerLazySingleton(() => GetTopRatedMovies(locator()))
    ..registerLazySingleton(() => GetMovieDetail(locator()))
    ..registerLazySingleton(() => GetMovieRecommendations(locator()))
    ..registerLazySingleton(() => SearchMovies(locator()))
    ..registerLazySingleton(() => GetWatchListStatusMovie(locator()))
    ..registerLazySingleton(() => SaveWatchlistMovie(locator()))
    ..registerLazySingleton(() => RemoveWatchlistMovie(locator()))
    ..registerLazySingleton(() => GetWatchlistMovies(locator()))

    // * TV SERIES LIST
    ..registerFactory(() => GetTvAiringToday(locator()))
    ..registerFactory(() => GetTvPopular(repository: locator()))
    ..registerFactory(() => GetTvTopRated(locator()))
    ..registerFactory(() => GetTvDetail(locator()))
    ..registerFactory(() => GetTvRecommendations(locator()))
    ..registerFactory(() => GetTvSearch(locator()))
    ..registerFactory(() => GetWatchlistTv(locator()))
    ..registerFactory(() => GetWatchlistStatusTv(locator()))
    ..registerFactory(() => SaveWatchlistTv(locator()))
    ..registerFactory(() => RemoveWatchlistTv(locator()))

    // repository
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
    )
    ..registerLazySingleton<TvSeriesRepository>(
      () => TvSeriesRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ),
    )

    // data sources
    ..registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()),
    )
    ..registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()),
    )
    ..registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(locator()),
    )
    ..registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()),
    )

    // helper
    ..registerLazySingleton<DatabaseHelper>(DatabaseHelper.new)

    // external
    ..registerLazySingleton(http.Client.new)

    // drawer
    ..registerLazySingleton(DrawerCubit.new);
}
