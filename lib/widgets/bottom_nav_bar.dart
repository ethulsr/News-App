import 'package:flutter/material.dart';
import 'package:news_today/utils/apptheme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.yellow,
      unselectedItemColor: Colors.red,
      backgroundColor: apptheme.secondaryColor,
    );
  }
}
