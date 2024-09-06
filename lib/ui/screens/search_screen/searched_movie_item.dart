import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListItem extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500${movie['cover']}',
            width: 140,
            height: 89,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Title
                Text(
                  movie['title'],
                  style: GoogleFonts.inder(
                    fontSize: 15,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w400
                  )
                ),
                const SizedBox(height: 4),

                Text(
                  movie['release_date'].toString().substring(0,4),
                  style: GoogleFonts.inder(
                      fontSize: 13,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w400
                  )
                ),
                const SizedBox(height: 4),
                Text(
                  '${movie['main_characters']}',
                  style: GoogleFonts.inder(
                      fontSize: 13,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w400
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}