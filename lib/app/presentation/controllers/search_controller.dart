import 'dart:async';
import 'package:get/get.dart';
import 'package:movie_app/app/domain/entities/movie.dart';
import 'package:movie_app/app/domain/usecases/search_movies.dart';

class SearchController extends GetxController {
  final SearchMovies _searchMovies;
  SearchController(this._searchMovies);

  final isLoading = false.obs;
  final searchResults = <Movie>[].obs;
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _performSearch(query);
      } else {
        searchResults.clear();
      }
    });
  }

  void _performSearch(String query) async {
    isLoading(true);
    final result = await _searchMovies.execute(query);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (movies) => searchResults.assignAll(movies),
    );
    isLoading(false);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}