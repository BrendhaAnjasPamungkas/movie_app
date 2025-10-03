// lib/app/presentation/pages/home_page.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/widgets/main_widget.dart';
import '/app/domain/entities/movie.dart';
import '/app/presentation/controllers/home_controller.dart';
import '/app/presentation/widgets/movie_card.dart';
import '/app/presentation/pages/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: W.text(data: 'MovieX'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            // <-- TOMBOL SEARCH BARU
            icon: const Icon(Icons.search),
            onPressed: () => Get.to(() => const SearchPage()),
          ),
          // <-- TAMBAHKAN BLOK INI
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed:
                controller.showSignOutConfirmationDialog, // <-- GANTI INI
            tooltip: 'Logout',
          ),
        ],
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
                const SizedBox(height: 9),
                _buildMovieSection('Popular', controller.popularMovies),
                const SizedBox(height: 9),
                _buildMovieSection('Top Rated', controller.topRatedMovies),
                const SizedBox(height: 9),
                _buildMovieSection('Upcoming', controller.upcomingMovies),
              ],
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          void show(dynamic value) {
            log(value.toString());
          }

          List<dynamic> data = [
            {
              "id": 1,
              "nama": "Andi",
              "hobi": ["Membaca", "Coding", "Olahraga"],
              "alamat": {
                "kota": "Jakarta",
                "kodePos": 12345,
                "riwayat": [
                  {"tahun": 2020, "kota": "Bandung"},
                  {"tahun": 2021, "kota": "Surabaya"},
                ],
              },
            },
            {
              "id": 2,
              "nama": "Budi",
              "hobi": ["Musik", "Fotografi"],
              "alamat": {
                "kota": "Medan",
                "kodePos": 67890,
                "riwayat": [
                  {"tahun": 2019, "kota": "Makassar"},
                  {
                    "tahun": 2022,
                    "kota": "Yogyakarta",
                    "detail": ["Kos", "Kontrak Rumah", "Apartemen"],
                  },
                ],
              },
            },
            [
              {
                "kategori": "Buah",
                "items": ["Apel", "Jeruk", "Pisang"],
              },
              {
                "kategori": "Minuman",
                "items": [
                  {"nama": "Kopi", "tipe": "Panas"},
                  {"nama": "Teh", "tipe": "Dingin"},
                ],
              },
            ],
          ];

          show(data[1]["alamat"]['riwayat'][1]['detail'][2]);
        },
      ),
    );
  }

  // Widget helper untuk membuat satu seksi (misal: "Now Playing")
  Widget _buildMovieSection(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 12.0),
          child: W.text(data: title, fontSize: 17, fontWeight: FontWeight.bold),
          // child: Text(
          //   title,
          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
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
