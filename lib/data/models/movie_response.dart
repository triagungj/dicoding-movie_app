import 'package:ditonton/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  const MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: (json['results'] as List)
            .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  final List<MovieModel> movieList;

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
