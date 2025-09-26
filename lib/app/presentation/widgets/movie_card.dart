// lib/app/presentation/widgets/movie_card.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/domain/entities/movie.dart';
import '/app/presentation/pages/detail_movie_page.dart';
import '/core/constants/api_constants.dart';
import '/core/widgets/main_widget.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // INI STRUKTUR YANG BENAR:
    // 1. GestureDetector (Pembungkus agar bisa di-klik)
    return GestureDetector(
      onTap: () {
        Get.to(() => const DetailMoviePage(), arguments: movie);
      },
      // 2. Container (Wadah utama yang punya ukuran dan margin)
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 130,
        // 3. Column (Isi dari kartu film)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                height: 180,
              ),
            ),
            W.gap(height: 8),
            W.text(
              data: movie.title,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}