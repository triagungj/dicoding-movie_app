import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  const TvSeriesDetailPage({required this.id, super.key});
  static const String routeName = '/tv-detail';
  final int id;

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .fetchTvSeriesDetail(widget.id);
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesDetailState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesDetailState == RequestState.loaded) {
            final tvSeries = provider.tvSeriesDetail;
            return SafeArea(
              child: DetailContent(
                tvSeries: tvSeries,
                recommendations: provider.tvSeriesRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    required this.tvSeries,
    required this.recommendations,
    required this.isAddedWatchlist,
    super.key,
  });
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Constants.kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name,
                              style: Constants.kHeading5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        '${tvSeries.numberOfSeasons} Season(s)',
                                      ),
                                      Text(
                                        '${tvSeries.numberOfEpisodes} Episodes',
                                      ),
                                    ],
                                  ),
                                ),
                                WatchlistButton(
                                  isAddedWatchlist: isAddedWatchlist,
                                  tvSeries: tvSeries,
                                ),
                              ],
                            ),
                            if (tvSeries.genres != null)
                              Text(
                                _showGenres(tvSeries.genres!),
                              ),
                            if (tvSeries.voteAverage != null)
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tvSeries.voteAverage! / 2,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Constants.kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tvSeries.voteAverage}')
                                ],
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Constants.kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            if (tvSeries.seasons != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Seasons',
                                    style: Constants.kHeading6,
                                  ),
                                  ListSeasonWidget(
                                    listSeason: tvSeries.seasons!,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Constants.kHeading6,
                            ),
                            Consumer<TvSeriesDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.tvSeriesRecommendationsState ==
                                    RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.tvSeriesRecommendationsState ==
                                    RequestState.error) {
                                  return Text(data.message);
                                } else if (data.tvSeriesRecommendationsState ==
                                    RequestState.loaded) {
                                  return ListTvSeriesWidget(
                                    listTvSeries: recommendations,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Constants.kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    final result = StringBuffer();

    for (final genre in genres) {
      result.write(genre.name);
    }
    final resultString = result.toString();

    if (resultString == '') {
      return resultString;
    }

    return resultString.substring(0, resultString.length - 2);
  }
}

class ListSeasonWidget extends StatelessWidget {
  const ListSeasonWidget({required this.listSeason, super.key});

  final List<Season> listSeason;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final season = listSeason[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 140,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: season.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${season.posterPath}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const Icon(Icons.image),
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  season.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '(${season.episodeCount} Episodes)',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
        itemCount: listSeason.length,
      ),
    );
  }
}

class ListTvSeriesWidget extends StatelessWidget {
  const ListTvSeriesWidget({
    required this.listTvSeries,
    super.key,
  });

  final List<TvSeries> listTvSeries;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = listTvSeries[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TvSeriesDetailPage.routeName,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: tvSeries.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const Icon(Icons.image),
              ),
            ),
          );
        },
        itemCount: listTvSeries.length,
      ),
    );
  }
}

class WatchlistButton extends StatelessWidget {
  const WatchlistButton({
    required this.isAddedWatchlist,
    required this.tvSeries,
    super.key,
  });

  final bool isAddedWatchlist;
  final TvSeriesDetail tvSeries;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!isAddedWatchlist) {
          await Provider.of<TvSeriesDetailNotifier>(
            context,
            listen: false,
          ).addWatchlist(tvSeries);
        } else {
          await Provider.of<TvSeriesDetailNotifier>(
            context,
            listen: false,
          ).removeWatchlist(tvSeries);
        }

        if (context.mounted) {
          final message = Provider.of<TvSeriesDetailNotifier>(
            context,
            listen: false,
          ).watchlistMessage;

          if (message == TvSeriesDetailNotifier.watchlistAddSuccessMessage ||
              message == TvSeriesDetailNotifier.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          } else {
            await showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAddedWatchlist)
            const Icon(Icons.check)
          else
            const Icon(Icons.add),
          const Text('Watchlist'),
        ],
      ),
    );
  }
}
