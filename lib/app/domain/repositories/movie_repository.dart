// lib/app/domain/repositories/movie_repository.dart

import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../entities/movie.dart'; // Kita akan buat file ini di langkah berikutnya

// Ini adalah kontrak atau blueprint.
// Setiap repository film HARUS memiliki fungsi-fungsi ini.
abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMovies({required String jenisfilm});
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
}
