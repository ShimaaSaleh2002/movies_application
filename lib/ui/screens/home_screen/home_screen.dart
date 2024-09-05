import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/ui/screens/home_screen/movies_screen.dart';
import 'package:movies_app/ui/screens/search_screen/search_screen.dart';
import 'package:movies_app/ui/screens/watchlist_screen/watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121312),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(color: Color(0xFFFFB224)),
          selectedLabelStyle: TextStyle(color: Colors.white),
          selectedItemColor: Color(0xFFFFB224),
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF1A1A1A),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: 'Watchlist',
            ),
          ],
        ),
        body: tabs[_currentTabIndex],
      ),
    );
  }

  List <Widget> tabs = [
    MoviesScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchlistScreen()
  ];
}
