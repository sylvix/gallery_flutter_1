import 'package:flutter/material.dart';
import 'package:gallery/screens/favorites_screen.dart';
import 'package:gallery/screens/gallery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _pageController = PageController();

  final _screens = [GalleryScreen(), FavoritesScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _pageController, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            label: 'Images',
            icon: Icon(Icons.image_outlined),
            activeIcon: Icon(Icons.image),
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
