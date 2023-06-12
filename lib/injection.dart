import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/cubit/drawer_cubit.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator
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

    // use case
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

    // repository
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
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

    // helper
    ..registerLazySingleton<DatabaseHelper>(DatabaseHelper.new)

    // external
    ..registerLazySingleton(http.Client.new)

    // drawer
    ..registerLazySingleton(DrawerCubit.new);
}
