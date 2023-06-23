import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_popular_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesPopularListPage extends StatefulWidget {
  const TvSeriesPopularListPage({super.key});

  static const routeName = '/tv-popular';

  @override
  State<TvSeriesPopularListPage> createState() =>
      _TvSeriesPopularListPageState();
}

class _TvSeriesPopularListPageState extends State<TvSeriesPopularListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesPopularNotifier>(context, listen: false)
          .fetchPopularTvSeries(),
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
        child: Consumer<TvSeriesPopularNotifier>(
          builder: (context, data, child) {
            if (data.tvSeriesPopularState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.tvSeriesPopularState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.listTvSeriesPopular[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: data.listTvSeriesPopular.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
