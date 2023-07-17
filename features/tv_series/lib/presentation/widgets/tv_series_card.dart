import 'package:common/styles.dart';
import 'package:core/constants.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

class TvSeriesCard extends StatelessWidget {
  const TvSeriesCard({required this.tvSeries, super.key});

  final TvSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            NamedRoutes.detailTvSeriesPage,
            arguments: tvSeries.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tvSeries.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.kHeading6,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tvSeries.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: tvSeries.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl:
                            '${Constants.baseImageUrl}${tvSeries.posterPath}',
                        width: 80,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
