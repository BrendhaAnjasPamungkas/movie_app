// lib/app/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/domain/entities/movie.dart';
import '/app/presentation/controllers/home_controller.dart';
import '/app/presentation/widgets/movie_card.dart';
import 'package:movie_app/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(
      getNowPlayingMovies: sl(),
      getPopularMovies: sl(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieX'),
        backgroundColor: Colors.black87,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // Ganti dengan layout scrollable
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMovieSection('Now Playing', controller.nowPlayingMovies),
                const SizedBox(height: 24),
                _buildMovieSection('Popular', controller.popularMovies),
              ],
            ),
          );
        }
      }),
    );
  }

  // Widget helper untuk membuat satu seksi (misal: "Now Playing")
  Widget _buildMovieSection(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 240, // Tinggi area list horizontal
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            // Tambahkan padding kiri untuk item pertama
            padding: const EdgeInsets.only(left: 8.0), 
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(movie: movie);
            },
          ),
        ),
      ],
    );
  }
}