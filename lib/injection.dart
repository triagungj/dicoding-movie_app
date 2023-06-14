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
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/cubit/drawer_cubit.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_airing_today_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator
    // * MOVIES
    ..registerFactory(
      () => MovieListNotifier(
        getNowPlayingMovies: locator(),
        getPopularMovies: locator(),
        getTopRatedMovies: locator(),
      ),
    )
    ..registerFactory(
      () => MovieDetailNotifier(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ),
    )
    ..registerFactory(
      () => MovieSearchNotifier(
        searchMovies: locator(),
      ),
    )
    ..registerFactory(
      () => PopularMoviesNotifier(
        locator(),
      ),
    )
    ..registerFactory(
      () => TopRatedMoviesNotifier(
        getTopRatedMovies: locator(),
      ),
    )
    ..registerFactory(
      () => WatchlistMovieNotifier(
        getWatchlistMovies: locator(),
      ),
    )
    // * TV SERIES
    ..registerFactory(
      () => TvSeriesListNotifier(locator(), locator(), locator()),
    )
    ..registerFactory(
      () => TvSeriesDetailNotifier(
        getTvDetail: locator(),
        getTvRecommendations: locator(),
        getWatchlistStatusTv: locator(),
        saveWatchlistTv: locator(),
        removeWatchlistTv: locator(),
      ),
    )
    ..registerFactory(() => TvSeriesAiringTodayNotifier(locator()))
    ..registerFactory(() => TvSeriesSearchNotifier(locator()))
    ..registerFactory(() => TvSeriesPopularNotifier(getTvPopular: locator()))
    ..registerFactory(() => TvSeriesTopRatedNotifier(locator()))
    ..registerFactory(() => WatchlistTvSeriesNotifier(locator()))

    // use case
    // * MOVIES
    ..registerLazySingleton(() => GetNowPlayingMovies(locator()))
    ..registerLazySingleton(() => GetPopularMovies(locator()))
    ..registerLazySingleton(() => GetTopRatedMovies(locator()))
    ..registerLazySingleton(() => GetMovieDetail(locator()))
    ..registerLazySingleton(() => GetMovieRecommendations(locator()))
    ..registerLazySingleton(() => SearchMovies(locator()))
    ..registerLazySingleton(() => GetWatchListStatus(locator()))
    ..registerLazySingleton(() => SaveWatchlist(locator()))
    ..registerLazySingleton(() => RemoveWatchlist(locator()))
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
