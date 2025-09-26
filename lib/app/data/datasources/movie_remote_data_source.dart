// lib/app/data/datasources/movie_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/error/exception.dart';
import '../models/movie_models.dart';

class MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSource({required this.client});

  // Fungsi untuk mengambil film Now Playing
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await client.get(Uri.parse(ApiConstants.nowPlayingMoviesPath));

    if (response.statusCode == 200) {
      // Jika server merespons dengan sukses (kode 200)
      final responseBody = json.decode(response.body);
      final List<dynamic> results = responseBody['results'];
      // Ubah setiap item di list JSON menjadi objek MovieModel
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      // Jika gagal, lemparkan error
      throw ServerException();
    }
  }

  // Fungsi untuk mengambil film Populer
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(Uri.parse(ApiConstants.popularMoviesPath));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List<dynamic> results = responseBody['results'];
      return results.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}