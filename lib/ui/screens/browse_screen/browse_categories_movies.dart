import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/browse_screen/inside_category_item.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../../data/api_manager.dart';
import '../home_screen/movie_details_screen.dart';

class BrowseMoviesByCategory extends StatelessWidget {
  final int genreId;
  final String genreName;

  const BrowseMoviesByCategory({super.key, required this.genreId, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('$genreName movies',style: const TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: ApiManager().getMoviesByGenre(genreId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No movies available.'));
          } else {
            final movies = snapshot.data!['results'] as List<dynamic>;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return InkWell(
                    onTap:() {

                    }
                    ,child: InkWell(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },child: InsideCategoryItem(movie: movie)));
              },
            );
          }
        },
      ),
    );
  }
}



