import 'package:flutter/material.dart';
import '../../../data/models/top_rated_movies_response.dart';
import '../../widgets/movie_carousal.dart';
import '../../widgets/top_rated_movies_list.dart';
import '../../widgets/upcoming_movie_list.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MovieCarousel(),
          const SizedBox(height: 20,),
          NewReleasesWidget(),
          const SizedBox(height: 25,),
          RecommendedMovies(onWatchlistUpdated: (List<Result> list) {  },),
        ],
      ),
    );
  }
}
