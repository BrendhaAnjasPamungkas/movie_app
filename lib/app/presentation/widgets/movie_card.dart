// lib/app/presentation/widgets/movie_card.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
    return Container(
      width: 130,
      child: GestureDetector(
        onTap: () {
          Get.to(() => const DetailMoviePage(), arguments: movie);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                  placeholder: (context, url) => Shimmer.fromColors(
                    child: Container(width: 130, color: Colors.black),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 130,
                    color: Colors.grey,
                    child: const Icon(Icons.error),
                  ),
                  fit: BoxFit.cover,
                  height: 180,
                ),
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
