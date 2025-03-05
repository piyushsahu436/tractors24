import 'package:flutter/material.dart';
import 'package:tractors24/screens/BottomNavigationBar/BottomBar.dart';
import 'package:tractors24/screens/Grids/MyAds.dart';
import 'package:tractors24/screens/HomePageF.dart';
import 'package:tractors24/screens/Seller_Form.dart';
import 'package:tractors24/screens/Wishlist.dart';
import 'package:tractors24/screens/drawer.dart';
import 'package:tractors24/screens/profile_screen.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageF(),
    PersonalAds(),
    Wishlist(),
    PersonalInfoScreen()
  ];

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Are you sure you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Stay on app
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
              },
              child: const Text("Yes"),
            ),
          ],
        ),
      ) ?? false; // Default to false if dialog is dismissed
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SellerformScreen()));
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
