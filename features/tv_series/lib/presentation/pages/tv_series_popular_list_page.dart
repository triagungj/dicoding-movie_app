import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';

class TvSeriesPopularListPage extends StatefulWidget {
  const TvSeriesPopularListPage({super.key});

  @override
  State<TvSeriesPopularListPage> createState() =>
      _TvSeriesPopularListPageState();
}

class _TvSeriesPopularListPageState extends State<TvSeriesPopularListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesPopularBloc>(context, listen: false).add(
        GetTvSeriesPopularEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            if (state is TvSeriesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesPopularSuccess) {
              final results = state.results;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = results[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: results.length,
              );
            } else if (state is TvSeriesPopularFailure) {
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
