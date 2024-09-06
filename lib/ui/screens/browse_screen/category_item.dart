import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String genreName;

  const CategoryItem({super.key, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 158,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/OIP.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Text(
              genreName,
              style:  TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.10),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
