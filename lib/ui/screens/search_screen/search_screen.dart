import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/ui/screens/search_screen/searched_movie_item.dart';
import 'package:movies_app/ui/widgets/loading_view.dart';
import '../../../data/api_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final results = await ApiManager().searchMovies(query);

    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isQueryEmpty = _searchController.text.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  fillColor: const Color(0xFF514F4F),
                  filled: true,
                  prefixIcon: const Icon(Icons.search,color: Colors.white,size: 17,),
                  hintText: 'Search',
                  hintStyle:GoogleFonts.inter(
                  color: const Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (query) {
                  _searchMovies(query);
                },
              ),
            ),

            const SizedBox(height: 18),
            if (_isLoading)
              const LoadingView(),

            if (isQueryEmpty && _searchResults.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_movies,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No movies found',
                        style: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                        )
                      ),
                    ],
                  ),
                ),
              ),

            if (!isQueryEmpty && !(_isLoading && _searchResults.isEmpty))
              Expanded(
                child: _searchResults.isEmpty
                    ? const Center(child: Text('No movies found'))
                    : ListView.separated(
                  itemCount: _searchResults.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final movie = _searchResults[index];
                    return MovieListItem(movie: movie);
                  },
                ),
              ),
          ],
        ),
    );
  }
}


