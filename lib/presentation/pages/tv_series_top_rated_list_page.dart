import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_top_rated_notifier.dart';
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
      () => Provider.of<TvSeriesTopRatedNotifier>(context, listen: false)
          .fetchTopRatedTv(),
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
        child: Consumer<TvSeriesTopRatedNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.listTopRated[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: data.listTopRated.length,
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
