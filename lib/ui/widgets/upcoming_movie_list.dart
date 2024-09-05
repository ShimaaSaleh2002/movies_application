import 'package:flutter/material.dart';
import '../../data/api_manager.dart';
import '../../data/models/upcoming_movies_response.dart';

class NewReleasesWidget extends StatefulWidget {
  @override
  _NewReleasesWidgetState createState() => _NewReleasesWidgetState();
}

class _NewReleasesWidgetState extends State<NewReleasesWidget> {
  List<Result> upcomingMovies = [];
  Set<int> watchlist = {};

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
      color: Color(0xFF282A28),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Releases',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.white),
          ),
          SizedBox(height: 16),
          Container(
            height: 128,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingMovies.length,
              itemBuilder: (context, index) {
                final movie = upcomingMovies[index];
                final isInWatchlist = watchlist.contains(movie.id);

                return Container(
                  width: 97,
                  margin: EdgeInsets.only(right: 16),
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
                                color: isInWatchlist ? Color(0xFFF7B539) : Color(0xFF514F4F),
                                size: 36,
                              ),
                              onPressed: () {
                                toggleWatchlist(movie.id, movie); // Add or remove movie from the watchlist
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
