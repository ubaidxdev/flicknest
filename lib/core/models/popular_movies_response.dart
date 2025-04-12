import 'movie_model.dart';

/// Represents a paginated response from TMDb API.
class PaginatedMovieResponse {
  final int page;
  final int totalPages;
  final List<Movie> movies;

  PaginatedMovieResponse({required this.page, required this.totalPages, required this.movies});

  factory PaginatedMovieResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedMovieResponse(
      page: json['page'],
      totalPages: json['total_pages'],
      movies: (json['results'] as List).map((item) => Movie.fromJson(item)).toList(),
    );
  }
}
