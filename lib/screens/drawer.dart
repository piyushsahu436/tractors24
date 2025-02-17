import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/dealer_dashboard/emi_cal.dart';
import 'package:tractors24/screens/faq_list.dart';
import 'package:tractors24/screens/faq_screen.dart';
import 'package:tractors24/screens/profile_screen.dart';
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
      title: Text(title,
          style: GoogleFonts.anybody(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF414141))),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Colors.black26,
      ),
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
              child: Text(userName,
                  style: GoogleFonts.anybody(
                      fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            accountEmail: Text(userEmail,
                style: GoogleFonts.anybody(
                    fontSize: 12, fontWeight: FontWeight.w600)),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person_4_outlined),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 5),
            child: Text(
              'Personal',
              style: GoogleFonts.anybody(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF414141)),
            ),
          ),

          // Menu Items
          _buildMenuListTile(
            icon: Icons.person,
            title: 'My Profile',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalInfoScreen()));
            },
          ),
          _buildMenuListTile(
            icon: Icons.favorite_outline,
            title: 'My Favourites',
            onTap: () {

            },
          ),
          SizedBox(height: 4),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          SizedBox(height: 4),
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
          SizedBox(height: 4),

          _buildMenuListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {},
          ),
          SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.share,
            title: 'Share App',
            onTap: () {},
          ),
          SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.reviews,
            title: 'Testimonials',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Testimonials()));
            },
          ),
          SizedBox(height: 4),
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
          SizedBox(height: 4),
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
          SizedBox(height: 4),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          SizedBox(height: 4),
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