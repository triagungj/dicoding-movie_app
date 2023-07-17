import 'package:components/app_drawer/app_drawer.dart';
import 'package:components/label_see_more/label_see_more.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/bloc/tv_series_airing_today/tv_series_airing_today_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';

class TvSeriesListPage extends StatefulWidget {
  const TvSeriesListPage({super.key});

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  void refresh() {
    Future.microtask(() {
      Provider.of<TvSeriesAiringTodayBloc>(context, listen: false)
          .add(GetTvSeriesAiringTodayEvent());
      Provider.of<TvSeriesPopularBloc>(context, listen: false)
          .add(GetTvSeriesPopularEvent());
      Provider.of<TvSeriesTopRatedBloc>(context, listen: false)
          .add(GetTvSeriesTopRatedEvent());
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton - TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                NamedRoutes.searchTvSeriesPage,
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },
        child: ListView(
          children: [
            LabelSeeMore(
              title: 'Airing Today',
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoutes.airingTodayTvSeriesPage,
              ),
            ),
            BlocBuilder<TvSeriesAiringTodayBloc, TvSeriesAiringTodayState>(
              builder: (context, state) {
                if (state is TvSeriesAiringTodayLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesAiringTodaySuccess) {
                  return Column(
                    children: List.generate(
                      state.results.length,
                      (index) => TvSeriesCard(tvSeries: state.results[index]),
                    ),
                  );
                } else if (state is TvSeriesAiringTodayFailure) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
            LabelSeeMore(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoutes.popularTvSeriesPage,
              ),
            ),
            BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
              builder: (context, state) {
                if (state is TvSeriesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesPopularSuccess) {
                  return Column(
                    children: List.generate(
                      state.results.length,
                      (index) => TvSeriesCard(tvSeries: state.results[index]),
                    ),
                  );
                } else if (state is TvSeriesPopularFailure) {
                  return Text(state.message);
                }

                return const SizedBox();
              },
            ),
            LabelSeeMore(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoutes.topRatedTvSeriesPage,
              ),
            ),
            BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
              builder: (context, state) {
                if (state is TvSeriesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesTopRatedSuccess) {
                  return Column(
                    children: List.generate(
                      state.results.length,
                      (index) => TvSeriesCard(tvSeries: state.results[index]),
                    ),
                  );
                } else if (state is TvSeriesTopRatedFailure) {
                  return Text(state.message);
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
