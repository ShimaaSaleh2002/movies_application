import 'package:flutter/material.dart';

import '../../data/models/search_response.dart';
import 'package:carousel_slider/carousel_slider.dart';


class SimilarMovieList extends StatelessWidget {
  final List<Results> similarMovies;
  final Function(int) onAddToWatchlist;

  const SimilarMovieList({super.key,
    required this.similarMovies,
    required this.onAddToWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 289,
      color: Colors.red,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: similarMovies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = similarMovies[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 199,
                        height: 129,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(Icons.save, color: Colors.yellow),
                        onPressed: () => onAddToWatchlist(movie.id!),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            movie.releaseDate!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${movie.voteAverage}/10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 0.8,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.black,
            child: Center(
              child: Text(
                'Similar Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

