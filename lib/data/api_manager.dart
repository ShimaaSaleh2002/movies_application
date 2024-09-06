import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/details_response.dart';
import 'models/popular_movies_response.dart';
import 'models/top_rated_movies_response.dart';
import 'models/upcoming_movies_response.dart';
import 'package:movies_app/data/models/popular_movies_response.dart' as popular;
import 'package:movies_app/data/models/top_rated_movies_response.dart' as topRated;
import 'package:movies_app/data/models/upcoming_movies_response.dart' as upcoming;


class ApiManager {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _popularMoviesEndPoint = "/movie/popular";
  static const String _topRatedMoviesEndPoint = "/movie/top_rated";
  static const String _upcomingMoviesEndPoint = "/movie/upcoming";
  static const String _accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDZiNmU2ZGFhZGEyMjgzMDhhNjliYmI3NTBhYzlmNiIsIm5iZiI6MTcyNTUyMzE3MC4yMzEwMjgsInN1YiI6IjY2ZDZhYzViNTdiM2Y1YTVjOWY3MGM1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WL_29eaGeZ3TyUdfA9RLU6qWpsTNatByenRYUMUQEjo";
  //final String _apiKey = '406b6e6daada228308a69bbb750ac9f6';

  static Future<PopularMoviesResponse> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl$_popularMoviesEndPoint'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return PopularMoviesResponse.fromJson(json);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  static Future<TopRatedMoviesResponse> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl$_topRatedMoviesEndPoint'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Parse JSON response
      Map<String, dynamic> json = jsonDecode(response.body);
      return TopRatedMoviesResponse.fromJson(json);
    } else {
      // Handle failure
      throw Exception('Failed to load top-rated movies');
    }
  }

  static Future<UpcomingMoviesResponse> getUpcomingMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl$_upcomingMoviesEndPoint'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Parse JSON response
      Map<String, dynamic> json = jsonDecode(response.body);
      return UpcomingMoviesResponse.fromJson(json);
    } else {
      // Handle failure
      throw Exception('Failed to load upcoming movies');
    }
  }


  Future<Details?> fetchMovieDetails(String movieId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/$movieId?api_key=$_accessToken&language=en-US'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Details.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getMovieImages(String movieId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/$movieId/images?api_key=$_accessToken'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load movie images');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getSimilarMovies(String movieId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/$movieId/similar?api_key=$_accessToken'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load similar movies');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/genre/movie/list?api_key=$_accessToken'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getMoviesByGenre(int? genreId) async {
    if (genreId == null) {
      print('Genre ID is null');
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/discover/movie?api_key=$_accessToken&with_genres=$genreId'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load movies by genre');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<List> getMovieCast(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId/credits?api_key=$_accessToken'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final castList = jsonResponse['cast'] as List;

      // Extract cast names (take the first 2 as an example)
      List mainCharacters = castList.take(2).map((castMember) {
        return castMember['name'];
      }).toList();

      return mainCharacters;
    } else {
      throw Exception('Failed to load movie cast');
    }
  }

  Future<String> _getMainCharacters(int movieId) async {
    List mainCharacters = await getMovieCast(movieId);
    return mainCharacters.join(', ');
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    List<Map<String, dynamic>> resultMovies = [];

    // Fetch all movies
    popular.PopularMoviesResponse popularMovies = await getPopularMovies();
    topRated.TopRatedMoviesResponse topRatedMovies = await getTopRatedMovies();
    upcoming.UpcomingMoviesResponse upcomingMovies = await getUpcomingMovies();

    // Combine all movies into one list
    List<dynamic> allMovies = [
      ...popularMovies.results,
      ...topRatedMovies.results,
      ...upcomingMovies.results
    ];

    // Filter movies based on the query
    for (var movie in allMovies) {
      if (movie.title.toLowerCase().contains(query.toLowerCase())) {
        // Fetch the main characters using the helper function
        String mainCharacters = await _getMainCharacters(movie.id);

        // Add formatted movie data to the results list
        resultMovies.add({
          'cover': movie.posterPath,
          'title': movie.title,
          'release_date': movie.releaseDate,
          'main_characters': mainCharacters,
        });
      }
    }

    return resultMovies;
  }

}
