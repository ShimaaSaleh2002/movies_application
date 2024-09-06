import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/screens/browse_screen/category_item.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../../data/api_manager.dart';
import 'browse_categories_movies.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121312),
        title: Text('Browse Category',style: GoogleFonts.inder(
          fontWeight: FontWeight.w400,
          fontSize: 22,
          color: Colors.white
        ),),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
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
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 30.0,
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
                    child: CategoryItem(
                      genreName: genre['name'] ?? 'Unknown Genre',
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}



