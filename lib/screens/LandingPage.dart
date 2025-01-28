import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tractors24/screens/BottomNavigationBar/BottomBar.dart';
import 'package:tractors24/screens/HomePageF.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0; // Track selected index

  final List<Widget> _pages = [
    const HomePageF(), // Home screen
    const Center(child: Text('EMI Calculator')),
    const Center(child: Text('Wishlist')),
    const Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavBar(
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _pages[_selectedIndex],
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            // Handle center button action
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, color: Colors.black),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .centerDocked, // Switch content dynamically
      ),
    );
  }
}
