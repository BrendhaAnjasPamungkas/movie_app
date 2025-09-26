// lib/app/presentation/controllers/home_controller.dart

import 'package:get/get.dart';
import '../../../app/domain/entities/movie.dart';
import '../../../app/domain/usecases/get_now_playing_movies.dart';
import '../../../app/domain/usecases/get_popular_movies.dart';

class HomeController extends GetxController {
  // 1. DEPENDENSI
  // Controller ini butuh use case untuk bekerja.
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;

  HomeController({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
  });

  // 2. STATE VARIABLES
  // Variabel yang akan didengarkan oleh UI.
  // '.obs' membuatnya menjadi "reaktif".
  final isLoading = true.obs;
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
}