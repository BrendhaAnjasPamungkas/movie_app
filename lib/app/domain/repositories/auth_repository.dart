// lib/app/domain/repositories/auth_repository.dart

import 'package:dartz/dartz.dart';
import '/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Kita akan mengembalikan objek User dari Firebase

abstract class AuthRepository {
  Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password);
  Future<Either<Failure, User>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure, void>> signOut(); // Mengembalikan Either<Failure, void> untuk operasi logout
}