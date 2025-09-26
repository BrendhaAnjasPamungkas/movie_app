// lib/core/constants/api_constants.dart

class ApiConstants {
  // Ganti dengan API Key Anda yang didapat dari TMDB
  static const String apiKey = '101c2a78fac25a9d700bfd4ace9f2fc1'; 
  
  static const String baseUrl = 'https://api.themoviedb.org/3';
  
  // Endpoint untuk mengambil film yang sedang tayang (Now Playing)
  static const String nowPlayingMoviesPath = '$baseUrl/movie/now_playing?api_key=$apiKey';

  // Endpoint untuk mengambil film populer
  static const String popularMoviesPath = '$baseUrl/movie/popular?api_key=$apiKey';

  // Base URL untuk gambar poster film
  // Gunakan w500 untuk kualitas gambar yang baik
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
}