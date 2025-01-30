import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const CustomBottomNavBar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem("assets/icons/homeI.png","assets/icons/homeI2.png", "Home", 0),
          _buildNavItem("assets/icons/adI.png","assets/icons/adI2.png", "My Ads", 1),
          const SizedBox(width: 40), // Space for center FAB
          _buildNavItem("assets/icons/favI.png","assets/icons/favI2.png", "Wishlist", 2),
          _buildNavItem("assets/icons/profile.png","assets/icons/personI2.png", "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String img1,String img2, String label, int index) {
    bool isSelected = widget.selectedIndex == index;

    return InkWell(
      onTap: () => widget.onItemSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(isSelected
                ? img1
                : img2,height: 24, // Deep blue for selected, grey for others
          ),
          Text(
            label,
            style: GoogleFonts.anybody(
              color: isSelected ? const Color(0xFF003B8F) : Colors.grey,
              fontSize: 13.44,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 30.0; // Increase this for a stronger curve

    Path path = Path();
    path.lineTo(0, curveHeight);

    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.40, 0);
    path.quadraticBezierTo(size.width * 0.50, 0, size.width * 0.60, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, curveHeight);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Selected Index: $_selectedIndex',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blue,
        buttonBackgroundColor: Colors.white,
        height: 60,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          const Icon(Icons.home, size: 30, color: Colors.white),
          const Icon(Icons.search, size: 30, color: Colors.white),
          const Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
