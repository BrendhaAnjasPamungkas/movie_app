import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:movie_app/app/domain/entities/movie.dart';
import 'package:movie_app/app/presentation/pages/detail_movie_page.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/widgets/main_widget.dart';
import 'package:shimmer/shimmer.dart';
import '/app/presentation/controllers/search_controller.dart';
import '/app/presentation/widgets/movie_card.dart';
import '/injection.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController(sl()));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: controller.onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search for a movie...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.searchResults.isEmpty) {
          return Center(child: W.text(data: 'Find Your Favorit Movie!'));
        }
        return ListView.builder(
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final Movie movie = controller.searchResults[index];

            return cardMovieSearch(movie);
          },
        );
      }),
    );
  }

  Widget cardMovieSearch(Movie movie) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: GestureDetector(
          onTap: () {
            Get.to(() => const DetailMoviePage(), arguments: movie);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey,
                      child: Container(color: Colors.black),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 160,
                      color: Colors.grey,
                      child: const Icon(Icons.error),
                    ),
                    fit: BoxFit.cover,
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
      ),
    );
  }
}
