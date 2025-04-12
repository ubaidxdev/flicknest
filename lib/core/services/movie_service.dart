import 'package:dio/dio.dart';
import 'package:flicknest/core/models/movie_model.dart';
import 'package:flicknest/core/models/popular_movies_response.dart';
import 'package:flicknest/core/services/api_service.dart';

/// Service to fetch movies using DioService
class MoviesService {
  final DioService _dioService = DioService();

  /// Fetch popular movies with pagination
  Future<PaginatedMovieResponse> getPopularMovies({int page = 1}) async {
    try {
      final response = await _dioService.get('/movie/popular', query: {'page': page});

      final data = response.data;

      return PaginatedMovieResponse.fromJson(data);
    } on DioException catch (e) {
      // Re-throw or handle more gracefully if needed
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Search movies by query string using the TMDb search API endpoint.
  Future<List<Movie>> searchMovies({required String query, int page = 1}) async {
    try {
      final response = await _dioService.get(
        '/search/movie',
        query: {'query': query, 'page': page},
      );

      final data = response.data;

      final List movies = data['results'] ?? [];
      if (movies.isEmpty) {
        return [];
      }
      return movies.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
