import 'package:flutter/material.dart';
import 'package:tractors24/screens/BottomNavigationBar/BottomBar.dart';
import 'package:tractors24/screens/Grids/MyAds.dart';
import 'package:tractors24/screens/HomePageF.dart';
import 'package:tractors24/screens/Seller_Form.dart';
import 'package:tractors24/screens/Wishlist.dart';
import 'package:tractors24/screens/drawer.dart';
import 'package:tractors24/screens/profile_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageF(),
    PersonalAds(),
    Wishlist(),
    PersonalInfoScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _pages[_selectedIndex],
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerformScreen()));
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.add, color: Colors.black),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      )
    );
  }
}
