import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class StylishBottomNavigation extends StatelessWidget {
  int selectedIndex;

  StylishBottomNavigation({
    super.key,
    required this.selectedIndex,
  });

  void _onItemTapped(int index, context) {
    if (index == 0) {
      GoRouter.of(context).go('/home');
    } else if (index == 1) {
      GoRouter.of(context).go('/cart');
    } else if (index == 2) {
      GoRouter.of(context).go('/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: (index) => _onItemTapped(index, context),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
              label: 'Cart', icon: Icon(Icons.shopping_cart), tooltip: 'Cart'),
          BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
              tooltip: 'Settings'),
        ],
      ),
    );
  }
}
