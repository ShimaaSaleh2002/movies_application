import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/popular_movies_response.dart';
import 'models/top_rated_movies_response.dart';
import 'models/upcoming_movies_response.dart';

class ApiManager {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _popularMoviesEndPoint = "/movie/popular";
  static const String _topRatedMoviesEndPoint = "/movie/top_rated";
  static const String _upcomingMoviesEndPoint = "/movie/upcoming";
  static const String _accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDZiNmU2ZGFhZGEyMjgzMDhhNjliYmI3NTBhYzlmNiIsIm5iZiI6MTcyNTUyMzE3MC4yMzEwMjgsInN1YiI6IjY2ZDZhYzViNTdiM2Y1YTVjOWY3MGM1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.WL_29eaGeZ3TyUdfA9RLU6qWpsTNatByenRYUMUQEjo";

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
}
