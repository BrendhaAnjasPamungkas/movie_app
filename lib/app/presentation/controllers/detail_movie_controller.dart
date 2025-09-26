// lib/app/presentation/controllers/detail_movie_controller.dart

import 'package:get/get.dart';
import '/app/domain/entities/movie.dart';

class DetailMovieController extends GetxController {
  // Variabel untuk menyimpan data film yang diterima.
  late final Movie movie;

  @override
  void onInit() {
    super.onInit();
    // Ambil data 'movie' yang dikirim melalui 'arguments'
    movie = Get.arguments as Movie;
  }
}