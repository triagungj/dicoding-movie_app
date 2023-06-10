import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  const TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvSeriesList: (json['results'] as List)
            .map((e) => TvSeriesModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  final List<TvSeriesModel> tvSeriesList;

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvSeriesList];
}
