// lib/app/domain/usecases/sign_out_user.dart

import 'package:dartz/dartz.dart';
import '/core/error/failure.dart';
import '/app/domain/repositories/auth_repository.dart';

class SignOutUser {
  final AuthRepository repository;
  SignOutUser(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.signOut();
  }
}