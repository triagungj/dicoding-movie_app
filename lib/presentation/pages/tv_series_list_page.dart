import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_airing_today_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_series_popular_list_page.dart';
import 'package:ditonton/presentation/pages/tv_series_search_page.dart';
import 'package:ditonton/presentation/pages/tv_series_top_rated_list_page.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/app_drawer.dart';
import 'package:ditonton/presentation/widgets/label_see_more.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesListPage extends StatefulWidget {
  const TvSeriesListPage({super.key});

  static const routeName = '/tv-series';

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  void refresh() {
    Future.microtask(
      () => Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..getAiringTodayTv()
        ..getPopularTv()
        ..getTopRatedTv(),
    );
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
              Navigator.pushNamed(context, TvSeriesSearchPage.routeName);
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
                TvSeriesAiringTodayPage.routeName,
              ),
            ),
            Consumer<TvSeriesListNotifier>(
              builder: (context, data, child) {
                final state = data.airingTodayTvState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvSeriesListWidget(data.airingTodayTv);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            LabelSeeMore(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                TvSeriesPopularListPage.routeName,
              ),
            ),
            Consumer<TvSeriesListNotifier>(
              builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvSeriesListWidget(data.popularTv);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            LabelSeeMore(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                TvSeriesTopRatedListPage.routeName,
              ),
            ),
            Consumer<TvSeriesListNotifier>(
              builder: (context, data, child) {
                final state = data.topRatedTvState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvSeriesListWidget(data.topRatedTv);
                } else {
                  return const Text('Failed');
                }
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
                  TvSeriesDetailPage.routeName,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
