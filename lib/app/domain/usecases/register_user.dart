import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/core/error/failure.dart';
import '/app/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;
  RegisterUser(this.repository);

  Future<Either<Failure, User>> execute(String email, String password) {
    return repository.registerWithEmailAndPassword(email, password);
  }
}