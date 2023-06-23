import 'package:dependencies/provider/provider.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_airing_today_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesAiringTodayPage extends StatefulWidget {
  const TvSeriesAiringTodayPage({super.key});

  static const routeName = '/tv-airing-today';

  @override
  State<TvSeriesAiringTodayPage> createState() =>
      _TvSeriesAiringTodaypageState();
}

class _TvSeriesAiringTodaypageState extends State<TvSeriesAiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesAiringTodayNotifier>(context, listen: false)
          .fetchAiringTodayTv(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TvSeriesAiringTodayNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.listAiringTodayTv[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: data.listAiringTodayTv.length,
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
