import 'package:flutter/material.dart';
import '../../data/api_manager.dart';
import '../../data/models/upcoming_movies_response.dart';

class NewReleasesWidget extends StatefulWidget {
  const NewReleasesWidget({super.key});

  @override
  _NewReleasesWidgetState createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
  List<Result> upcomingMovies = [];
  Set<int> watchlist = {};
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
    fetchUpcomingMovies();
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      UpcomingMoviesResponse response = await ApiManager.getUpcomingMovies();
      setState(() {
        upcomingMovies = response.results;
      });
    } catch (error) {
      // Handle error
      print('Error fetching upcoming movies: $error');
    }
  }

  void toggleWatchlist(int movieId, Result movie) {
    setState(() {
      if (watchlist.contains(movieId)) {
        watchlist.remove(movieId);
      } else {
        watchlist.add(movieId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF282A28),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Releases',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 128,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingMovies.length,
              itemBuilder: (context, index) {
                final movie = upcomingMovies[index];
                final isInWatchlist = watchlist.contains(movie.id);

                return Container(
                  width: 97,
                  margin: const EdgeInsets.only(right: 16),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 97,
                          height: 128,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: -13,
                        left: -15,
                        child: Stack(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.bookmark,
                                color: isPressed
                                    ? const Color(0xFFF7B539)
                                    : const Color(0xFF514F4F),
                                size: 36,
                              ),
                              onPressed: () {
                                isPressed = !isPressed;
                                setState(() {});
                              },
                            ),
                            Positioned(
                              top: 11,
                              left: 14,
                              child: Icon(
                                isInWatchlist ? Icons.done : Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
