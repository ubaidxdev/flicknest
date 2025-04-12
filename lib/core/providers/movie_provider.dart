import 'dart:convert';

import 'package:flicknest/core/models/movie_model.dart';
import 'package:flicknest/core/services/movie_service.dart';
import 'package:flicknest/core/services/storage_service.dart';
import 'package:flutter/foundation.dart';

/// Provider class for handling popular movies pagination and caching.
class MoviesProvider with ChangeNotifier {
  MoviesProvider() {
    // Load cached data when the provider is initialized.
    loadCachedData();
  }
  final MoviesService _moviesService = MoviesService();
  final StorageService _storageService = StorageService.instance;

  static const String popularMoviesCacheKey = 'popular_movies';
  static const String favoriteMoviesCacheKey = 'favorite_movies';

  final List<Movie> _popularMovies = [];
  final List<Movie> _favorites = [];
  final List<Movie> _searchResults = [];

  bool _isSearching = false;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  bool _isPaginating = false;

  List<Movie> get popularMovies => _isSearching ? _searchResults : _popularMovies;
  List<Movie> get favorites => _favorites;
  bool get isSearching => _isSearching;
  bool get isLoading => _isLoading;
  bool get isPaginating => _isPaginating;
  int get currentPage => _currentPage;
  bool get hasMore => _currentPage < _totalPages;

  /// Call this after StorageService is initialized (e.g., in main.dart)
  Future<void> loadCachedData() async {
    _loadPopularMoviesFromCache();
    _loadFavoritesFromCache();
  }

  /// Load popular movies from SharedPreferences.
  void _loadPopularMoviesFromCache() {
    final List<String> cachedList = _storageService.getList(popularMoviesCacheKey);
    if (cachedList.isNotEmpty) {
      _popularMovies.clear();
      _popularMovies.addAll(
        cachedList.map((movieString) => Movie.fromJson(json.decode(movieString))),
      );
      notifyListeners();
    }
  }

  /// Load favorite movies from SharedPreferences.
  void _loadFavoritesFromCache() {
    final List<String> cachedFavs = _storageService.getList(favoriteMoviesCacheKey);
    if (cachedFavs.isNotEmpty) {
      _favorites.clear();
      _favorites.addAll(cachedFavs.map((movieString) => Movie.fromJson(json.decode(movieString))));
      notifyListeners();
    }
  }

  /// Update the cache for popular movies.
  Future<void> _cachePopularMovies() async {
    List<String> encodedMovies =
        _popularMovies.map((movie) => json.encode(movie.toJson())).toList();
    await _storageService.setList(popularMoviesCacheKey, encodedMovies);
  }

  /// Update the cache for favorite movies.
  Future<void> _cacheFavorites() async {
    List<String> encodedFavorites = _favorites.map((movie) => json.encode(movie.toJson())).toList();
    await _storageService.setList(favoriteMoviesCacheKey, encodedFavorites);
  }

  /// Load the first page or reload all popular movies.
  Future<void> loadInitialMovies() async {
    _isLoading = true;
    _isPaginating = false;
    _currentPage = 1;

    // Load any cached popular movies first so that they're available offline.
    _loadPopularMoviesFromCache();
    notifyListeners();

    try {
      final result = await _moviesService.getPopularMovies(page: _currentPage);
      // Clear the list and update it if data is available.
      _popularMovies.clear();
      _popularMovies.addAll(result.movies);
      _totalPages = result.totalPages;
      await _cachePopularMovies();
    } catch (e) {
      debugPrint('❌ Failed to fetch popular movies from API: $e');
      // In case of error, the cached data (if any) remains displayed.
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Load the next page of popular movies.
  Future<void> loadMoreMovies() async {
    if (_isPaginating || _isLoading || !hasMore) return;

    _isPaginating = true;
    _currentPage++;
    notifyListeners();

    try {
      final result = await _moviesService.getPopularMovies(page: _currentPage);
      _popularMovies.addAll(result.movies);
      _totalPages = result.totalPages;
      await _cachePopularMovies();
    } catch (e) {
      debugPrint('❌ Failed to fetch popular movies from API: $e');
      // Roll back the page number if the fetch fails.
      _currentPage = _currentPage > 1 ? _currentPage - 1 : 1;
    }

    _isPaginating = false;
    notifyListeners();
  }

  // --- Search functionality ---
  Future<void> searchMovies(String query) async {
    _isSearching = query.isNotEmpty;
    _searchResults.clear();

    if (query.isEmpty) {
      notifyListeners();
      return;
    }

    try {
      final results = await _moviesService.searchMovies(query: query);
      _searchResults.addAll(results);
      notifyListeners();
    } catch (e) {
      debugPrint("Search error: $e");
    }
  }

  void clearSearch() {
    _isSearching = false;
    _searchResults.clear();
    notifyListeners();
  }

  // --- Favorite functionality ---
  void toggleFavorite(Movie movie) {
    // Toggle the movie's favorite status.
    if (_favorites.any((fav) => fav.id == movie.id)) {
      _favorites.removeWhere((fav) => fav.id == movie.id);
    } else {
      _favorites.add(movie);
    }
    // Update favorites cache after modifying favorites list.
    _cacheFavorites();
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.any((fav) => fav.id == movie.id);
  }
}
