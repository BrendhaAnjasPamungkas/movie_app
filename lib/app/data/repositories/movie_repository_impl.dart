// lib/app/data/repositories/movie_repository_impl.dart
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../models/movie_models.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final List<MovieModel> movieModels = await remoteDataSource.getNowPlayingMovies();
      // INI BAGIAN YANG DIPERBAIKI:
      // Kita ubah List<MovieModel> menjadi List<Movie>
      final List<Movie> movies = movieModels.map((model) => Movie(
        id: model.id,
        title: model.title,
        overview: model.overview,
        posterPath: model.posterPath,
      )).toList();
      
      return Right(movies);

    } on ServerException {
      return const Left(ServerFailure('Gagal mengambil data dari server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final List<MovieModel> movieModels = await remoteDataSource.getPopularMovies();
      // INI JUGA DIPERBAIKI:
      final List<Movie> movies = movieModels.map((model) => Movie(
        id: model.id,
        title: model.title,
        overview: model.overview,
        posterPath: model.posterPath,
      )).toList();

      return Right(movies);

    } on ServerException {
      return const Left(ServerFailure('Gagal mengambil data dari server'));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal terhubung ke internet'));
    }
  }
}