// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mirathi_book_app/views/form_page.dart';
import 'package:mirathi_book_app/views/projects_page.dart';
import 'package:mirathi_book_app/views/table_page.dart';
import 'package:mirathi_book_app/views/tours_page.dart';
import 'package:mirathi_book_app/views/users_page.dart';
import 'package:mirathi_book_app/views/users_scroll_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    FormPage(),
    // UsersScrollPage(),
    // TablePage(),
    // ProjectScrollPage(),
    UsersPage(),
    ToursPage(),
    // Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Demo'),
      ),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the index when a tab is tapped
          });
        },
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
