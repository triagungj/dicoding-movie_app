import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/bloc/tv_series_airing_today/tv_series_airing_today_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';

class TvSeriesAiringTodayPage extends StatefulWidget {
  const TvSeriesAiringTodayPage({super.key});

  @override
  State<TvSeriesAiringTodayPage> createState() =>
      _TvSeriesAiringTodaypageState();
}

class _TvSeriesAiringTodaypageState extends State<TvSeriesAiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesAiringTodayBloc>(context, listen: false).add(
        GetTvSeriesAiringTodayEvent(),
      ),
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
        child: BlocBuilder<TvSeriesAiringTodayBloc, TvSeriesAiringTodayState>(
          builder: (context, state) {
            if (state is TvSeriesAiringTodayLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesAiringTodaySuccess) {
              final results = state.results;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = results[index];
                  return TvSeriesCard(tvSeries: tvSeries);
                },
                itemCount: results.length,
              );
            } else if (state is TvSeriesAiringTodayFailure) {
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
