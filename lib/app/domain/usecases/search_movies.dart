import 'package:dartz/dartz.dart';
import '/app/domain/entities/movie.dart';
import '/app/domain/repositories/movie_repository.dart';
import '/core/error/failure.dart';


class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}