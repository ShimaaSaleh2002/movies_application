import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../../data/api_manager.dart';
import 'browse_categories_movies.dart';


class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late Future<List<Map<String, dynamic>>?> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
  }

  Future<List<Map<String, dynamic>>?> fetchCategories() async {
    var response = await ApiManager().getCategories();

    if (response != null && response['genres'] != null) {
      List<dynamic> genres = response['genres'];
      return genres.map((genre) => genre as Map<String, dynamic>).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No categories available.'));
        } else {
          final categories = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 40.0,
                mainAxisSpacing: 40.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final genre = categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrowseMoviesByCategory(
                          genreId: genre['id'],
                          genreName: genre['name'] ?? 'Unknown Genre',
                        ),
                      ),
                    );
                  },
                  child: CategoryCard(
                    genreName: genre['name'] ?? 'Unknown Genre',
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String genreName;

  CategoryCard({required this.genreName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 158,
      color: Colors.red,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/OIP.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(
              genreName,
              style:  TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


