import 'package:common/styles.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card.dart';

class TvSeriesSearchPage extends StatelessWidget {
  const TvSeriesSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<TvSeriesSearchBloc>(context, listen: false).add(
                  GetTvSeriesSearchEvent(query),
                );
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: Styles.kHeading6,
            ),
            BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
              builder: (context, state) {
                if (state is TvSeriesSearchLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is TvSeriesSearchSuccess) {
                  final results = state.results;
                  if (results.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text('Result not found'),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = results[index];
                        return TvSeriesCard(tvSeries: tvSeries);
                      },
                      itemCount: results.length,
                    ),
                  );
                } else if (state is TvSeriesSearchFailure) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }
                return Expanded(
                  child: Container(
                    key: const Key('emptyContainer'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
