// lib/app/data/models/movie_model.dart

import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  // Factory constructor ini bertugas mengubah data JSON (berbentuk Map)
  // menjadi objek MovieModel.
  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
      );

  // 'props' dari package Equatable membantu kita untuk membandingkan
  // dua objek MovieModel berdasarkan isinya, bukan lokasi memorinya.
  @override
  List<Object?> get props => [id, title, overview, posterPath];
}