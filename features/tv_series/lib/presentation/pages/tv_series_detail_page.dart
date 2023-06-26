import 'package:common/genre.dart';
import 'package:common/styles.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_recommendation/tv_series_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_watchlist_insert/tv_series_watchlist_insert_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_watchlist_remove/tv_series_watchlist_remove_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_watchlist_status/tv_series_watchlist_status_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  const TvSeriesDetailPage({required this.id, super.key});

  final int id;

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailBloc>(context, listen: false)
          .add(GetTvSeriesDetailEvent(widget.id));
      Provider.of<TvSeriesWatchlistStatusBloc>(context, listen: false)
          .add(GetTvSeriesWatchlistStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvSeriesDetailSuccess) {
            Provider.of<TvSeriesRecommendationsBloc>(
              context,
              listen: false,
            ).add(GetTvSeriesRecommendationsEvent(widget.id));
            final tvSeries = state.result;
            return SafeArea(
              child: DetailContent(
                tvSeries: tvSeries,
              ),
            );
          } else if (state is TvSeriesDetailFailure) {
            return Text(state.message);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    required this.tvSeries,
    super.key,
  });
  final TvSeriesDetail tvSeries;

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
                  color: Styles.kRichBlack,
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
                              style: Styles.kHeading5,
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
                                      color: Styles.kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tvSeries.voteAverage}')
                                ],
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Styles.kHeading6,
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
                                    style: Styles.kHeading6,
                                  ),
                                  ListSeasonWidget(
                                    listSeason: tvSeries.seasons!,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Styles.kHeading6,
                            ),
                            BlocBuilder<TvSeriesRecommendationsBloc,
                                TvSeriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvSeriesRecommendationsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvSeriesRecommendationsFailure) {
                                  return Text(state.message);
                                } else if (state
                                    is TvSeriesRecommendationsSuccess) {
                                  return ListTvSeriesWidget(
                                    listTvSeries: state.results,
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
            backgroundColor: Styles.kRichBlack,
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
                  style: Styles.kSubtitle,
                ),
                Text(
                  '(${season.episodeCount} Episodes)',
                  style: Styles.kBodyText,
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
                  NamedRoutes.detailTvSeriesPage,
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
    required this.tvSeries,
    super.key,
  });

  final TvSeriesDetail tvSeries;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TvSeriesWatchlistInsertBloc, TvSeriesWatchlistInsertState>(
          listener: (contex, state) {
            if (state is TvSeriesWatchlistInsertSuccess) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Provider.of<TvSeriesWatchlistStatusBloc>(
                context,
                listen: false,
              ).add(
                GetTvSeriesWatchlistStatusEvent(tvSeries.id),
              );
            } else if (state is TvSeriesWatchlistInsertFailure) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                },
              );
            }
          },
        ),
        BlocListener<TvSeriesWatchlistRemoveBloc, TvSeriesWatchlistRemoveState>(
          listener: (contex, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            if (state is TvSeriesWatchlistRemoveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Provider.of<TvSeriesWatchlistStatusBloc>(
                context,
                listen: false,
              ).add(
                GetTvSeriesWatchlistStatusEvent(tvSeries.id),
              );
            } else if (state is TvSeriesWatchlistRemoveFailure) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                },
              );
            }
          },
        ),
      ],
      child: BlocBuilder<TvSeriesWatchlistStatusBloc, bool>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (!state) {
                Provider.of<TvSeriesWatchlistInsertBloc>(
                  context,
                  listen: false,
                ).add(AddTvSeriesWatchlistInsertEvent(tvSeries));
              } else {
                Provider.of<TvSeriesWatchlistRemoveBloc>(
                  context,
                  listen: false,
                ).add(AddTvSeriesWatchlistRemoveEvent(tvSeries));
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state) const Icon(Icons.check) else const Icon(Icons.add),
                const Text('Watchlist'),
              ],
            ),
          );
        },
      ),
    );
  }
}
