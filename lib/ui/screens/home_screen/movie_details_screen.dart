import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../../data/api_manager.dart';
import '../../../data/models/popular_movies_response.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Result movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Map<String, dynamic>?> _similarMoviesFuture;
  late Future<Map<String, dynamic>?> _movieImagesFuture;

  get watchlist => null;

  @override
  void initState() {
    super.initState();
    _similarMoviesFuture =
        ApiManager().getSimilarMovies(widget.movie.id.toString());
    _movieImagesFuture =
        ApiManager().getMovieImages(widget.movie.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: const Color(0xFF121312),
        appBar: AppBar(
          title: Text(movie.title,
              style: GoogleFonts.inder(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: const Color(0xFF121312),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  height: 217.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                movie.title,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                )
              ),
              const SizedBox(height : 3),
              Row(
                children: [
                  Text(
                    movie.releaseDate.toString().substring(0,4),
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    'PG-13',
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                    )
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    '2h 50m',
                    style: GoogleFonts.inter(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w400
                    )
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<Map<String, dynamic>?>(
                      future: _movieImagesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const LoadingView();
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          var movieImages =
                              snapshot.data?['backdrops'] as List<dynamic>?;

                          if (movieImages == null || movieImages.isEmpty) {
                            return const Center(
                                child: Text('No images available.'));
                          }

                          return SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: movieImages.length,
                              itemBuilder: (context, index) {
                                var image = movieImages[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${image['file_path']}',
                                    fit: BoxFit.cover,
                                    width: 130.0,
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('No movie images available.'));
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 16.0),
                          Text(
                            movie.overview,
                            style: GoogleFonts.inter(
                                color: Colors.white54,
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                            )
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const Icon(Icons.star,color: Colors.yellow,size: 20,),
                              const SizedBox(width: 5,),
                              Text(
                                movie.voteAverage.toString().substring(0,3),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),









              // Similar Movies
              FutureBuilder<Map<String, dynamic>?>(
                future: _similarMoviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingView();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    var similarMovies = snapshot.data?['results'] as List<dynamic>?;

                    if (similarMovies == null || similarMovies.isEmpty) {
                      return const Center(child: Text('No similar movies found.'));
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'More like this',
                            style: GoogleFonts.inder(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 200.0,
                            child: CarouselSlider.builder(
                              itemCount: similarMovies.length,
                              itemBuilder: (context, index, realIndex) {
                                var movie = similarMovies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(movie: movie),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(
                                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            color: Colors.black.withOpacity(0.5),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              movie['title'] ?? 'No title available',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 200.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text('No similar movies available.'));
                  }
                },
              )

            ],
          ),
        ),
      ),
    );
  }

  void toggleWatchlist(movie) {}
}
