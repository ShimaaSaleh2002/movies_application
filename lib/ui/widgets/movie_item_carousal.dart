import 'package:flutter/material.dart';
import '../../data/models/popular_movies_response.dart';

class MovieItemCarousal extends StatelessWidget {
  final Result movie;
  final bool isInWatchlist;
  final Function(int movieId) toggleWatchlist;

  const MovieItemCarousal({
    required this.movie,
    this.isInWatchlist = false,
    required this.toggleWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            height: 217,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                height: 199,
                width: 129,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: -7,
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: isInWatchlist ? const Color(0xFFF7B539) : const Color(0xFF514F4F),
                    size: 36,
                  ),
                  onPressed: () {
                    toggleWatchlist(movie.id);
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

          Positioned(
            left: 155,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                        "${movie.releaseDate.year}  ",
                        style: const TextStyle(color: Colors.white)
                    ),
                    const Text("PG-13", style: TextStyle(color: Colors.white)),
                    const Text("  2h 7m", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
