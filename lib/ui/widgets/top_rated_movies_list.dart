import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../data/api_manager.dart';
import '../../data/models/top_rated_movies_response.dart';

class RecommendedMovies extends StatefulWidget {
  final Function(List<Result>) onWatchlistUpdated;

  const RecommendedMovies({super.key, required this.onWatchlistUpdated});

  @override
  _RecommendedMoviesState createState() => _RecommendedMoviesState();
}

class _RecommendedMoviesState extends State<RecommendedMovies> {
  late Future<TopRatedMoviesResponse> _topRatedMoviesFuture;
  Set<int> watchlist = {}; // Store movie IDs in the watchlist

  @override
  void initState() {
    super.initState();
    _topRatedMoviesFuture = ApiManager.getTopRatedMovies();
  }

  void toggleWatchlist(int movieId, Result movie) {
    setState(() {
      if (watchlist.contains(movieId)) {
        watchlist.remove(movieId);
      } else {
        watchlist.add(movieId);
      }
      widget.onWatchlistUpdated(watchlist.cast<Result>().toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF282A28),
      height: 286,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recommended',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder<TopRatedMoviesResponse>(
              future: _topRatedMoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingView();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
                  return const Center(child: Text('No top-rated movies available.'));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data!.results.map((movie) {
                      bool isInWatchlist = watchlist.contains(movie.id);

                      return Container(
                        width: 97,
                        height: 225,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: const Color(0xFF343534),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 128,
                                  width: 97,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
                                          color: isInWatchlist ? const Color(0xFFF7B539) : const Color(0xFF514F4F),
                                          size: 36,
                                        ),
                                        onPressed: () {
                                          toggleWatchlist(movie.id, movie); 
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.yellow, size: 10),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${movie.voteAverage}',
                                        style: const TextStyle(color: Colors.white, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    movie.title,
                                    style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${movie.releaseDate.year} PG-13 2h 50m',
                                    style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
