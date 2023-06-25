import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/injection.dart' as di;
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
import 'package:ditonton/presentation/cubit/drawer_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_series_airing_today_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series_list_page.dart';
import 'package:ditonton/presentation/pages/tv_series_popular_list_page.dart';
import 'package:ditonton/presentation/pages/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/tv_series_top_rated_list_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/tv_series_airing_today_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<MoviesNowPlayingBloc>(
          create: (_) => di.locator<MoviesNowPlayingBloc>(),
        ),
        BlocProvider<MovieWatchlistInsertBloc>(
          create: (_) => di.locator<MovieWatchlistInsertBloc>(),
        ),
        BlocProvider<MovieWatchlistLoadBloc>(
          create: (_) => di.locator<MovieWatchlistLoadBloc>(),
        ),
        BlocProvider<MovieWatchlistRemoveBloc>(
          create: (_) => di.locator<MovieWatchlistRemoveBloc>(),
        ),
        BlocProvider<MoviesNowPlayingBloc>(
          create: (_) => di.locator<MoviesNowPlayingBloc>(),
        ),
        BlocProvider<MoviesPopularBloc>(
          create: (_) => di.locator<MoviesPopularBloc>(),
        ),
        BlocProvider<MoviesRecommendationBloc>(
          create: (_) => di.locator<MoviesRecommendationBloc>(),
        ),
        BlocProvider<MoviesSearchBloc>(
          create: (_) => di.locator<MoviesSearchBloc>(),
        ),
        BlocProvider<MoviesTopRatedBloc>(
          create: (_) => di.locator<MoviesTopRatedBloc>(),
        ),
        BlocProvider<MovieWatchlistStatusBloc>(
          create: (_) => di.locator<MovieWatchlistStatusBloc>(),
        ),

        //

        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesAiringTodayNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DrawerCubit>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: Constants.kColorScheme,
          primaryColor: Constants.kRichBlack,
          scaffoldBackgroundColor: Constants.kRichBlack,
          textTheme: Constants.kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.routeName:
              return CupertinoPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case MovieDetailPage.routeName:
              final id = settings.arguments as int?;
              return CupertinoPageRoute(
                builder: (_) => MovieDetailPage(id: id!),
                settings: settings,
              );
            case SearchMoviePage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const SearchMoviePage(),
              );
            case TvSeriesListPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesListPage(),
              );
            case TvSeriesSearchPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesSearchPage(),
              );
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int?;
              return CupertinoPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id!),
                settings: settings,
              );
            case TvSeriesAiringTodayPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesAiringTodayPage(),
              );
            case TvSeriesPopularListPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesPopularListPage(),
              );
            case TvSeriesTopRatedListPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesTopRatedListPage(),
              );
            case WatchlistPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const WatchlistPage(),
              );
            case AboutPage.routeName:
              return CupertinoPageRoute(builder: (_) => const AboutPage());
            default:
              return CupertinoPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
