import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_load/movie_watchlist_load_bloc.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/app_drawer.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  static const routeName = '/watchlist-movie';

  @override
  WatchlistPageState createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage> with RouteAware {
  final isMovie = ValueNotifier<bool>(true);

  void refresh() {
    Future.microtask(
      () {
        if (isMovie.value) {
          Provider.of<MovieWatchlistLoadBloc>(context, listen: false)
              .add(GetMovieWatchlistLoadEvent());
        } else {
          Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
              .fetchWatchlistTv();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    isMovie.addListener(refresh);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder<bool>(
        valueListenable: isMovie,
        builder: (context, value, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                watchlistButton(context),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: isMovie.value ? watchlistMovie() : watchlistTvSeries(),
                ),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }

  BlocBuilder<MovieWatchlistLoadBloc, MovieWatchlistLoadState>
      watchlistMovie() {
    return BlocBuilder<MovieWatchlistLoadBloc, MovieWatchlistLoadState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoadLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieWatchlistLoadSuccess) {
          final movies = state.results;
          return movies.isNotEmpty
              ? Column(
                  children: List.generate(
                    movies.length,
                    (index) => MovieCard(movies[index]),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: Text('Your Watchlist Movies is empty'),
                  ),
                );
        } else if (state is MovieWatchlistLoadFailure) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Consumer<WatchlistTvSeriesNotifier> watchlistTvSeries() {
    return Consumer<WatchlistTvSeriesNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.loaded) {
          final listTvSeries = data.listWatchlistTv;
          return listTvSeries.isNotEmpty
              ? Column(
                  children: List.generate(
                    listTvSeries.length,
                    (index) => TvSeriesCard(tvSeries: listTvSeries[index]),
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: Text('Your Watchlist Tv Series is empty'),
                  ),
                );
        } else {
          return Center(
            key: const Key('error_message'),
            child: Text(data.message),
          );
        }
      },
    );
  }

  SingleChildScrollView watchlistButton(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          watchlistTypeButton(
            context: context,
            isActive: isMovie.value,
            title: 'Movie',
            onTap: () {
              isMovie.value = true;
            },
          ),
          const SizedBox(width: 10),
          watchlistTypeButton(
            context: context,
            isActive: !isMovie.value,
            title: 'TV Series',
            onTap: () {
              isMovie.value = false;
            },
          ),
        ],
      ),
    );
  }

  OutlinedButton watchlistTypeButton({
    required BuildContext context,
    required String title,
    required bool isActive,
    void Function()? onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
        foregroundColor: isActive
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
      ),
      child: Text(title),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
