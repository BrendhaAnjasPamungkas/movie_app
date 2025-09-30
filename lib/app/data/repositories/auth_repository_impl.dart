// lib/app/data/repositories/auth_repository_impl.dart

import 'dart:io'; // Untuk SocketException
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Untuk objek User

import '/app/data/datasources/auth_remote_data_source.dart';
import '/app/domain/repositories/auth_repository.dart';
import '/core/error/exception.dart';
import '/core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await remoteDataSource.registerWithEmailAndPassword(email, password);
      return Right(userCredential.user!); // Pastikan user tidak null
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await remoteDataSource.signInWithEmailAndPassword(email, password);
      return Right(userCredential.user!); // Pastikan user tidak null
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null); // Return Right(null) untuk operasi void yang sukses
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the internet'));
    }
  }
}