import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({required this.id, super.key});
  static const routeName = '/detail';

  final int id;

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.movieState == RequestState.loaded) {
            final movie = provider.movie;
            return SafeArea(
              child: DetailContent(
                movie: movie,
                recommendations: provider.movieRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(
              provider.message,
              key: const Key('textErrorWidget'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    required this.movie,
    required this.recommendations,
    required this.isAddedWatchlist,
    super.key,
  });
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        if (movie.posterPath != null)
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        else
          Container(
            key: const Key('containerPoster'),
            padding: const EdgeInsets.only(top: 20),
            width: screenWidth,
            child: Icon(
              Icons.image,
              size: screenWidth / 2,
              color: Theme.of(context).colorScheme.onBackground,
            ),
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
                              movie.title,
                              style: Constants.kHeading5,
                            ),
                            WatchlistButton(
                              isAddedWatchlist: isAddedWatchlist,
                              movie: movie,
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Constants.kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Constants.kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Constants.kHeading6,
                            ),
                            Consumer<MovieDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.error) {
                                  return Text(
                                    data.message,
                                    key: const Key('textRecommendationError'),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.loaded) {
                                  return ListRecommendationsWidget(
                                    recommendations: recommendations,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
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

  String _showDuration(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class ListRecommendationsWidget extends StatelessWidget {
  const ListRecommendationsWidget({
    required this.recommendations,
    super.key,
  });

  final List<Movie> recommendations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = recommendations[index];
          return Padding(
            key: const Key('recommendationCard'),
            padding: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
        itemCount: recommendations.length,
      ),
    );
  }
}

class WatchlistButton extends StatelessWidget {
  const WatchlistButton({
    required this.isAddedWatchlist,
    required this.movie,
    super.key,
  });

  final bool isAddedWatchlist;
  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!isAddedWatchlist) {
          await Provider.of<MovieDetailNotifier>(
            context,
            listen: false,
          ).addWatchlist(movie);
        } else {
          await Provider.of<MovieDetailNotifier>(
            context,
            listen: false,
          ).removeFromWatchlist(movie);
        }

        if (context.mounted) {
          final message = Provider.of<MovieDetailNotifier>(
            context,
            listen: false,
          ).watchlistMessage;

          if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
              message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
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
