import 'package:common/genre.dart';
import 'package:common/styles.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/flutter_rating_bar/flutter_rating_bar.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_watchlist_insert/movie_watchlist_insert_bloc.dart';
import 'package:movies/presentation/bloc/movie_watchlist_remove/movie_watchlist_remove_bloc.dart';
import 'package:movies/presentation/bloc/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/movies_recommendations/movies_recommendation_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({required this.id, super.key});

  final int id;

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailBloc>(context, listen: false).add(
        GetMovieDetailEvent(widget.id),
      );
      Provider.of<MovieWatchlistStatusBloc>(context, listen: false).add(
        GetMovieWatchlistStatusEvent(widget.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailSuccess) {
            Provider.of<MoviesRecommendationBloc>(context, listen: false).add(
              GetMoviesRecommendationEvent(widget.id),
            );
            Provider.of<MovieWatchlistStatusBloc>(context, listen: false).add(
              GetMovieWatchlistStatusEvent(widget.id),
            );
            final movie = state.result;
            return SafeArea(
              child: DetailContent(
                movie: movie,
                key: const Key('detailContent'),
              ),
            );
          } else if (state is MovieDetailFailure) {
            return Text(
              state.message,
              key: const Key('textErrorWidget'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    required this.movie,
    super.key,
  });
  final MovieDetail movie;

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
                              movie.title,
                              style: Styles.kHeading5,
                            ),
                            BlocBuilder<MovieWatchlistStatusBloc, bool>(
                              builder: (context, state) {
                                return WatchlistButton(
                                  isAddedWatchlist: state,
                                  movie: movie,
                                );
                              },
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
                                    color: Styles.kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: Styles.kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: Styles.kHeading6,
                            ),
                            BlocBuilder<MoviesRecommendationBloc,
                                MoviesRecommendationState>(
                              builder: (context, state) {
                                if (state is MoviesRecommendationFailure) {
                                  return Text(
                                    state.message,
                                    key: const Key('textRecommendationError'),
                                  );
                                } else if (state
                                    is MoviesRecommendationSuccess) {
                                  return ListRecommendationsWidget(
                                    recommendations: state.results,
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
                  NamedRoutes.detailMoviePage,
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
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieWatchlistInsertBloc, MovieWatchlistInsertState>(
          listener: (context, state) {
            if (state is MovieWatchlistInsertSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Provider.of<MovieWatchlistStatusBloc>(context, listen: false).add(
                GetMovieWatchlistStatusEvent(movie.id),
              );
            }
            if (state is MovieWatchlistInsertFailure) {
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
        BlocListener<MovieWatchlistRemoveBloc, MovieWatchlistRemoveState>(
          listener: (context, state) {
            if (state is MovieWatchlistRemoveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Provider.of<MovieWatchlistStatusBloc>(context, listen: false).add(
                GetMovieWatchlistStatusEvent(movie.id),
              );
            }
            if (state is MovieWatchlistRemoveFailure) {
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
        )
      ],
      child: ElevatedButton(
        onPressed: () async {
          if (!isAddedWatchlist) {
            Provider.of<MovieWatchlistInsertBloc>(
              context,
              listen: false,
            ).add(AddMovieWatchlistInsertEvent(movie));
          } else {
            Provider.of<MovieWatchlistRemoveBloc>(
              context,
              listen: false,
            ).add(AddMovieWatchlistRemoveEvent(movie));
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
      ),
    );
  }
}
