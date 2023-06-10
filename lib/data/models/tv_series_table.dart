import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  const TvSeriesTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TvSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        overview: tvSeries.overview,
        posterPath: tvSeries.posterPath,
      );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
        id: map['id'] as int,
        name: map['name'] as String,
        posterPath: map['posterPath'] as String,
        overview: map['overview'] as String,
      );
  final int id;
  final String name;
  final String overview;
  final String posterPath;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeries toEntity() => TvSeries.watchList(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}
