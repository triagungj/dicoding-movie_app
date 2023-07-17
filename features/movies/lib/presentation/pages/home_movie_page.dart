import 'package:common/styles.dart';
import 'package:components/app_drawer/app_drawer.dart';
import 'package:components/label_see_more/label_see_more.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/bloc/movies_now_playing/movies_now_playing_bloc.dart';
import 'package:movies/presentation/bloc/movies_popular/movies_popular_bloc.dart';
import 'package:movies/presentation/bloc/movies_top_rated/movies_top_rated_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

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
                NamedRoutes.searchMoviePage,
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
                style: Styles.kHeading6,
              ),
            ),
            BlocBuilder<MoviesNowPlayingBloc, MoviesNowPlayingState>(
              builder: (context, state) {
                if (state is MoviesNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesNowPlayingSuccess) {
                  return Column(
                    children: List.generate(
                      state.result.length,
                      (index) => MovieCard(state.result[index]),
                    ),
                  );
                } else if (state is MoviesNowPlayingFailure) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
            LabelSeeMore(
              key: const Key('seeAllPopularMovies'),
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoutes.popularMoviePage,
              ),
            ),
            BlocBuilder<MoviesPopularBloc, MoviesPopularState>(
              builder: (context, state) {
                if (state is MoviesPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesPopularSuccess) {
                  return Column(
                    children: List.generate(
                      state.result.length,
                      (index) => MovieCard(state.result[index]),
                    ),
                  );
                } else if (state is MoviesPopularFailure) {
                  return Text(state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
            LabelSeeMore(
              key: const Key('seeAllTopRated'),
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoutes.topRatedMoviePage,
              ),
            ),
            BlocBuilder<MoviesTopRatedBloc, MoviesTopRatedState>(
              builder: (context, state) {
                if (state is MoviesTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MoviesTopRatedSuccess) {
                  return Column(
                    children: List.generate(
                      state.result.length,
                      (index) => MovieCard(state.result[index]),
                    ),
                  );
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
