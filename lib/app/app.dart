import 'package:common/styles.dart';
import 'package:components/app_drawer/cubit/drawer_cubit.dart';
import 'package:core/named_routes.dart';
import 'package:core/utils.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/app/pages/about_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';

class App extends StatelessWidget {
  const App({super.key});

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

        BlocProvider<TvSeriesAiringTodayBloc>(
          create: (_) => di.locator<TvSeriesAiringTodayBloc>(),
        ),
        BlocProvider<TvSeriesPopularBloc>(
          create: (_) => di.locator<TvSeriesPopularBloc>(),
        ),
        BlocProvider<TvSeriesTopRatedBloc>(
          create: (_) => di.locator<TvSeriesTopRatedBloc>(),
        ),
        BlocProvider<TvSeriesDetailBloc>(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider<TvSeriesRecommendationsBloc>(
          create: (_) => di.locator<TvSeriesRecommendationsBloc>(),
        ),
        BlocProvider<TvSeriesSearchBloc>(
          create: (_) => di.locator<TvSeriesSearchBloc>(),
        ),
        BlocProvider<TvSeriesWatchlistLoadBloc>(
          create: (_) => di.locator<TvSeriesWatchlistLoadBloc>(),
        ),
        BlocProvider<TvSeriesWatchlistInsertBloc>(
          create: (_) => di.locator<TvSeriesWatchlistInsertBloc>(),
        ),
        BlocProvider<TvSeriesWatchlistStatusBloc>(
          create: (_) => di.locator<TvSeriesWatchlistStatusBloc>(),
        ),
        BlocProvider<TvSeriesWatchlistRemoveBloc>(
          create: (_) => di.locator<TvSeriesWatchlistRemoveBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<DrawerCubit>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: Styles.kColorScheme,
          primaryColor: Styles.kRichBlack,
          scaffoldBackgroundColor: Styles.kRichBlack,
          textTheme: Styles.kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case NamedRoutes.moviePage:
              return CupertinoPageRoute(builder: (_) => const HomeMoviePage());
            case NamedRoutes.popularMoviePage:
              return CupertinoPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case NamedRoutes.topRatedMoviePage:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case NamedRoutes.detailMoviePage:
              final id = settings.arguments as int?;
              return CupertinoPageRoute(
                builder: (_) => MovieDetailPage(id: id!),
                settings: settings,
              );
            case NamedRoutes.searchMoviePage:
              return CupertinoPageRoute(
                builder: (_) => const SearchMoviePage(),
              );
            case NamedRoutes.tvSeriesPage:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesListPage(),
              );
            case NamedRoutes.searchTvSeriesPage:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesSearchPage(),
              );
            case NamedRoutes.detailTvSeriesPage:
              final id = settings.arguments as int?;
              return CupertinoPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id!),
                settings: settings,
              );
            case NamedRoutes.airingTodayTvSeriesPage:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesAiringTodayPage(),
              );
            case NamedRoutes.popularTvSeriesPage:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesPopularListPage(),
              );
            case NamedRoutes.topRatedTvSeriesPage:
              return CupertinoPageRoute(
                builder: (_) => const TvSeriesTopRatedListPage(),
              );
            case NamedRoutes.watchlistPage:
              return CupertinoPageRoute(
                builder: (_) => const WatchlistPage(),
              );
            case NamedRoutes.aboutPage:
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
