import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  const GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  final int id;
  final String name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  Genre toEntity() {
    return Genre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
