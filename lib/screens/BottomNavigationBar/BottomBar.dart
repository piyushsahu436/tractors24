import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onItemSelected;

  const CustomBottomNavBar({Key? key, required this.onItemSelected}) : super(key: key);

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
          _buildNavItem(Icons.home_rounded, "Home", 0),
          _buildNavItem(Icons.calculate, "EMI Calc", 1),
          const SizedBox(width: 40), // Space for center button
          _buildNavItem(Icons.favorite, "Wishlist", 2),
          _buildNavItem(Icons.person, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => widget.onItemSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.grey),
          Text(label,style: GoogleFonts.anybody(
            color: const Color(0xFF003B8F),
            fontSize: 13.44,
            fontWeight: FontWeight.w500,
          ),),
        ],
      ),
    );
  }
}
