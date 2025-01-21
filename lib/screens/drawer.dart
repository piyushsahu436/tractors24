import 'package:flutter/material.dart';
import 'package:tractors24/screens/faq_screen.dart';
import 'package:tractors24/screens/news.dart';
import 'package:tractors24/screens/emi_cal.dart';
import 'package:tractors24/screens/update_profile_screen.dart';
import 'package:tractors24/screens/policies_screen.dart';
import 'package:tractors24/screens/testimonials.dart';

class CustomDrawer extends StatelessWidget {
  // Dummy data
  final String userName = "John Doe";
  final String userEmail = "john.doe@example.com";
  final String userPhotoUrl = "https://via.placeholder.com/150";

  const CustomDrawer({super.key});

  // Define common text styles
  static const TextStyle _menuItemStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _userNameStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _userEmailStyle = TextStyle(
    fontSize: 14.0,
  );

  // Custom MenuListTile Widget
  Widget _buildMenuListTile({
    required IconData icon,
    required String title,
    Color iconColor = Colors.black,
    TextStyle? style,
    VoidCallback? onTap,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(title, style: style ?? _menuItemStyle),
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
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            
            accountName: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(userName, style: _userNameStyle),
            ),
            accountEmail: Text(userEmail, style: _userEmailStyle),
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
            icon: Icons.settings,
            title: 'Account Settings',
            onTap: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(builder: (context) =>UpdateProfileScreen())
              );
            },
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
            icon: Icons.favorite_outline,
            title: 'My Favourites',
            onTap: () {

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
                MaterialPageRoute(builder: (context) => FAQScreen()),
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
          _buildMenuListTile(
            icon: Icons.report,
            title: 'Grievance Redressel',
            onTap: () {

            },
          ),

          const Divider(height: 1),

          // Logout
          _buildMenuListTile(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],

      ),
    );
  }
}