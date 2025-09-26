// lib/core/error/failure.dart

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// Kegagalan umum dari sisi server
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

// Kegagalan saat tidak ada koneksi internet
class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);
}