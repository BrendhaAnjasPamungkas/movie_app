// lib/app/presentation/pages/detail_movie_page.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/presentation/controllers/detail_movie_controller.dart';
import '/core/constants/api_constants.dart';
import '/core/widgets/main_widget.dart';

class DetailMoviePage extends StatelessWidget {
  const DetailMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi controller untuk halaman ini
    final controller = Get.put(DetailMovieController());

    return Scaffold(
      appBar: AppBar(
        // Judul AppBar diambil dari judul film
        title: W.text(data: controller.movie.title),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. POSTER FILM
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '${ApiConstants.baseImageUrl}${controller.movie.posterPath}',
                  width: MediaQuery.of(context).size.width * 0.6, // 60% lebar layar
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            W.gap(height: 24),

            // 2. JUDUL FILM
            W.text(
              data: controller.movie.title,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            W.gap(height: 16),

            // 3. SINOPSIS/OVERVIEW
            W.text(
              data: 'Synopsis',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            W.gap(height: 8),
            W.text(
              data: controller.movie.overview,
              fontSize: 14,
              textAlign: TextAlign.justify, // Rata kanan-kiri
            ),
          ],
        ),
      ),
    );
  }
}