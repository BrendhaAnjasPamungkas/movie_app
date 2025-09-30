// lib/core/error/exception.dart
// lib/core/error/exception.dart
class ServerException implements Exception {
  final String message;

  ServerException(this.message); // Tambahkan constructor untuk menerima pesan
}