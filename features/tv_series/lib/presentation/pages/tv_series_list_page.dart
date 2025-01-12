import 'package:components/app_drawer/app_drawer.dart';
import 'package:components/label_see_more/label_see_more.dart';
import 'package:core/constants.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/tv_series_airing_today/tv_series_airing_today_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';

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
                  return TvSeriesListWidget(state.results);
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
                  return TvSeriesListWidget(state.results);
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
                  return TvSeriesListWidget(state.results);
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

class TvSeriesListWidget extends StatelessWidget {
  const TvSeriesListWidget(this.tvSeriesList, {super.key});
  final List<TvSeries> tvSeriesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NamedRoutes.detailTvSeriesPage,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '${Constants.baseImageUrl}${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
