// lib/app/presentation/controllers/home_controller.dart

import 'package:get/get.dart';
import 'package:movie_app/injection.dart';
import '../../../app/domain/entities/movie.dart';
import '../../../app/domain/usecases/get_now_playing_movies.dart';
import '../../../app/domain/usecases/get_popular_movies.dart';
import '/app/domain/usecases/sign_out_user.dart'; // <-- 1. IMPORT USE CASE LOGOUT
import '/app/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  // 1. DEPENDENSI
  // Controller ini butuh use case untuk bekerja.
  final GetNowPlayingMovies getNowPlayingMovies = sl<GetNowPlayingMovies>();
  final GetPopularMovies getPopularMovies = sl<GetPopularMovies>();
  final SignOutUser signOutUser = sl<SignOutUser>();

  // HomeController({
  // required this.getNowPlayingMovies,
  //   required this.getPopularMovies,
  // });

  // 2. STATE VARIABLES
  // Variabel yang akan didengarkan oleh UI.
  // '.obs' membuatnya menjadi "reaktif".
  final RxBool isLoading = true.obs;
  final RxList<Movie> nowPlayingMovies = <Movie>[].obs;
  final RxList<Movie> popularMovies = <Movie>[].obs;

  // 3. LIFECYCLE METHOD
  // Metode ini otomatis dijalankan saat controller pertama kali dibuat.
  @override
  void onInit() {
    super.onInit();
    // Langsung panggil fungsi untuk mengambil data saat halaman dibuka
    fetchInitialMovies();
  }

  // 4. LOGIC METHODS
  // Fungsi yang berisi logika untuk mengambil data.
  void fetchInitialMovies() async {
    // Mulai loading
    isLoading(true);

    // Panggil use case untuk Now Playing Movies
    final nowPlayingResult = await getNowPlayingMovies.execute();
    nowPlayingResult.fold(
      (failure) {
        // Jika gagal, bisa tampilkan pesan error
        print('Error Now Playing: ${failure.message}');
      },
      (movies) {
        // Jika berhasil, masukkan datanya ke state variable
        nowPlayingMovies.assignAll(movies);
      },
    );

    // Panggil use case untuk Popular Movies
    final popularResult = await getPopularMovies.execute();
    popularResult.fold(
      (failure) {
        // Jika gagal
        print('Error Popular: ${failure.message}');
      },
      (movies) {
        // Jika berhasil
        popularMovies.assignAll(movies);
      },
    );

    // Selesai loading
    isLoading(false);
  }

  void signOut() async {
    final result = await signOutUser.execute();
    result.fold(
      (Failure) {
        Get.snackbar('Error', Failure.message);
      },
      (_) {
        Get.offAll(() => const LoginPage());
      },
    );
  }
  void performSignOut() async {
      // <-- Metode yang akan menjalankan proses logout
      final result = await signOutUser.execute();
      result.fold(
        (failure) {
          Get.snackbar('Error', failure.message);
        },
        (_) {
          Get.offAll(() => const LoginPage());
        },
      );
    }
  void showSignOutConfirmationDialog() {
      // <-- Metode baru untuk menampilkan dialog
      Get.defaultDialog(
        title: "Logout Confirmation",
        middleText: "Are you sure you want to log out?",
        textConfirm: "Yes",
        textCancel: "No",
        confirmTextColor: Colors.white,
        buttonColor: Colors.red, // Warna tombol konfirmasi merah
        cancelTextColor: Get.isDarkMode
            ? Colors.white
            : Colors.black, // Warna teks tombol batal
        onConfirm: () {
          Get.back(); // Tutup dialog
          performSignOut(); // Lanjutkan dengan proses logout
        },
        onCancel: () {
          Get.back(); // Tutup dialog jika batal
        },
      );
    }
}
