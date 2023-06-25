import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies_now_playing/movies_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_popular/movies_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_top_rated/movies_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/widgets/app_drawer.dart';
import 'package:ditonton/presentation/widgets/label_see_more.dart';
import 'package:flutter/material.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  static const routeName = '/home';

  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<MoviesNowPlayingBloc>(context, listen: false).add(
          GetNowPlayingMoviesEvent(),
        );
        Provider.of<MoviesPopularBloc>(context, listen: false).add(
          GetMoviesPopularEvent(),
        );
        Provider.of<MoviesTopRatedBloc>(context, listen: false).add(
          GetMoviesTopRatedEvent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton - Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchMoviePage.routeName,
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                'Now Playing',
                style: Constants.kHeading6,
              ),
            ),
            BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
              builder: (context, state) {
                if (state is MoviesNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesNowPlayingSuccess) {
                  return MovieList(state.result);
                } else if (state is MoviesNowPlayingFailure) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
            LabelSeeMore(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                PopularMoviesPage.routeName,
              ),
            ),
            BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
              builder: (context, state) {
                if (state is MoviesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesPopularSuccess) {
                  return MovieList(state.result);
                } else if (state is MoviesPopularFailure) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
            LabelSeeMore(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                TopRatedMoviesPage.routeName,
              ),
            ),
            BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
              builder: (context, state) {
                if (state is MoviesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesTopRatedSuccess) {
                  return MovieList(state.result);
                } else if (state is MoviesTopRatedFailure) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList(this.movies, {super.key});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '${Constants.baseImageUrl}${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
