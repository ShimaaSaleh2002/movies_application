import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../data/api_manager.dart';
import '../../data/models/popular_movies_response.dart';
import '../screens/home_screen/movie_details_screen.dart';
import 'movie_item_carousal.dart';

class MovieCarousel extends StatefulWidget {
  const MovieCarousel({super.key});

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  List<Result> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    try {
      PopularMoviesResponse response = await ApiManager.getPopularMovies();
      setState(() {
        movies = response.results;
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching popular movies: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingView()
        : Container(
      height: 289,
      color: const Color(0xFF121312),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CarouselSlider.builder(
              itemCount: movies.length,
              options: CarouselOptions(
                height: 289,
                autoPlay: true,
                viewportFraction: 1.0,
              ),
              itemBuilder: (context, index, realIndex) {
                final movie = movies[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: MovieItemCarousal(
                    movie: movie,
                    toggleWatchlist: (int movieId) {
                      // Your watchlist logic here
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
