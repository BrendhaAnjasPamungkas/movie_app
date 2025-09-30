// lib/app/data/datasources/auth_remote_data_source.dart

import 'package:firebase_auth/firebase_auth.dart';
import '/core/error/exception.dart';// Import exception kita

// Kontrak/Interface untuk AuthRemoteDataSource
abstract class AuthRemoteDataSource {
  Future<UserCredential> registerWithEmailAndPassword(String email, String password);
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut(); // Untuk logout
}

// Implementasi AuthRemoteDataSource yang berbicara dengan Firebase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance; // Menggunakan instance default jika tidak disediakan

  @override
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Tangkap error spesifik dari Firebase Auth
      throw ServerException(e.message ?? 'Unknown Firebase Auth error');
    } catch (e) {
      // Tangkap error umum lainnya
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase Auth error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Unknown Firebase Auth error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}