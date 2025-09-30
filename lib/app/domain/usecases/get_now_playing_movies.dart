// lib/app/domain/usecases/get_now_playing_movies.dart

import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMoviesusecase {
  final MovieRepository repository;

  GetMoviesusecase(this.repository);

  Future<Either<Failure, List<Movie>>> getMovies({required String jenisfilm}) {
    return repository.getMovies(jenisfilm: jenisfilm);
  }
}
