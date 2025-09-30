// lib/injection.dart

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'app/data/datasources/movie_remote_data_source.dart';
import 'app/data/repositories/movie_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app/domain/repositories/movie_repository.dart';
import 'app/domain/usecases/get_now_playing_movies.dart';
import '/app/data/datasources/auth_remote_data_source.dart'; // <-- TAMBAHKAN INI
import '/app/data/repositories/auth_repository_impl.dart'; // <-- TAMBAHKAN INI
import '/app/domain/repositories/auth_repository.dart';
import '/app/domain/usecases/register_user.dart';
import '/app/domain/usecases/login_user.dart';
import '/app/domain/usecases/sign_out_user.dart';

// Membuat instance dari GetIt sebagai Service Locator kita.
// Kita beri nama 'sl' (service locator).
final sl = GetIt.instance;

void init() {
  //LOGIN DAN REGISTER DISINI
  sl.registerFactory(() => RegisterUser(sl()));
  sl.registerFactory(() => LoginUser(sl()));
  sl.registerFactory(() => SignOutUser(sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  //FITUR AUTHENTIKASI
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  //DATASOURCE
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
    ), // Memerlukan instance FirebaseAuth
  );
  // === FITUR: MOVIE ===

  // -- Use Cases --
  // Use case tidak butuh state, jadi kita daftarkan sebagai factory.
  // Artinya, setiap kali kita panggil sl<GetPopularMovies>(),P
  // instance baru akan dibuat.
  sl.registerFactory(() => GetMoviesusecase(sl()));

  // -- Repository --
  // Repository kita daftarkan sebagai lazy singleton.
  // Artinya, objeknya hanya akan dibuat satu kali saat pertama kali dipanggil.
  // Kita daftarkan kontrak (abstract class) lalu berikan implementasinya.
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: sl()),
  );

  // -- Data Sources --
  // Data source juga kita daftarkan sebagai lazy singleton.
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSource(client: sl()),
  );

  // === EXTERNAL ===
  // Daftarkan juga dependency dari package luar (http client).
  sl.registerLazySingleton(() => http.Client());
}
