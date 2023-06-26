import 'package:components/app_drawer/cubit/drawer_cubit.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:dependencies/http/http.dart' as http;
import 'package:movies/data/datasources/db/movies_db_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/movies_usecase.dart';
import 'package:movies/presentation/bloc/movies_bloc.dart';
import 'package:tv_series/data/datasources/db/tv_series_db_helper.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:tv_series/domain/usecases/tv_series_usecase.dart';
import 'package:tv_series/presentation/bloc/tv_series_bloc.dart';

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
    ..registerLazySingleton<MoviesDbHelper>(MoviesDbHelper.new)
    ..registerLazySingleton<TvSeriesDbHelper>(TvSeriesDbHelper.new)

    // external
    ..registerLazySingleton(http.Client.new)

    // drawer
    ..registerLazySingleton(DrawerCubit.new);
}
