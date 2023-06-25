import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesTopRatedListPage extends StatefulWidget {
  const TvSeriesTopRatedListPage({super.key});

  static const routeName = '/tv-top-rated';

  @override
  State<TvSeriesTopRatedListPage> createState() =>
      _TvSeriesTopRatedListPageState();
}

class _TvSeriesTopRatedListPageState extends State<TvSeriesTopRatedListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesTopRatedBloc>(context, listen: false).add(
        GetTvSeriesTopRatedEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, state) {
            if (state is TvSeriesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesTopRatedSuccess) {
              final results = state.results;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = results[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: results.length,
              );
            } else if (state is TvSeriesTopRatedFailure) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
