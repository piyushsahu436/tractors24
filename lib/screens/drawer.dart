import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/faq_screen.dart';
import 'package:tractors24/screens/news.dart';
import 'package:tractors24/screens/emi_cal.dart';
import 'package:tractors24/screens/update_profile_screen.dart';
import 'package:tractors24/screens/policies_screen.dart';
import 'package:tractors24/screens/testimonials.dart';

class CustomDrawer extends StatelessWidget {

  final String userName = "John Doe";
  final String userEmail = "john.doe@example.com";
  final String userPhotoUrl = "https://via.placeholder.com/150";


  const CustomDrawer({super.key});


  // Custom MenuListTile Widget
  Widget _buildMenuListTile({
    required IconData icon,
    required String title,
    Color iconColor = const Color(0xFF0A2472),
    TextStyle? style,
    VoidCallback? onTap,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(title, style: GoogleFonts.anybody(fontSize: 12, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User Account Header
          UserAccountsDrawerHeader(
            accountName: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(userName, style: GoogleFonts.anybody(fontSize: 12, fontWeight: FontWeight.w600) ),
            ),
            accountEmail: Text(userEmail, style: GoogleFonts.anybody(fontSize: 12, fontWeight: FontWeight.w600)),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person_4_outlined),

            ),
          ),

          // Menu Items
          _buildMenuListTile(
            icon: Icons.person,
            title: 'My Profile',
            onTap: () {

            },
          ),
          _buildMenuListTile(
            icon: Icons.favorite_outline,
            title: 'My Favourites',
            onTap: () {

            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),

          _buildMenuListTile(
            icon: Icons.calculate,
            title: 'EMI Calculator',
            onTap: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(builder: (context) => EMICalculatorScreen())
              );

            },
          ),
          _buildMenuListTile(
            icon: Icons.newspaper,
            title: 'News',
            onTap: () {
              Navigator.push(
                (context),
                MaterialPageRoute(builder: (context)=> SavedArticlesScreen ()),
              );
            },
          ),

          _buildMenuListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {


            },
          ),

          _buildMenuListTile(
            icon: Icons.share,
            title: 'Share App',
            onTap: () {

            },
          ),

          _buildMenuListTile(
            icon: Icons.reviews,
            title: 'Testimonials',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Testimonials()));

            },
          ),
          _buildMenuListTile(
            icon: Icons.question_answer,
            title: 'Frequently Asked Questions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQList()),
              );

            },
          ),
          _buildMenuListTile(
            icon: Icons.policy,
            title: 'Policies',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PoliciesScreen()),
              );
            },
          ),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),

          // Logout
          _buildMenuListTile(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Color(0xFF0A2472),
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A2472),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],

      ),
    );
  }
}