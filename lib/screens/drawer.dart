
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_password.dart';
import 'package:tractors24/screens/Wishlist.dart';
import 'package:tractors24/screens/dealer_dashboard/emi_cal.dart';
import 'package:tractors24/screens/faq_screen.dart';
import 'package:tractors24/screens/notification.dart';
import 'package:tractors24/screens/profile_screen.dart';
import 'package:tractors24/screens/policies_screen.dart';
import 'package:tractors24/screens/testimonials.dart';

import 'favorites_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final String userPhotoUrl = "https://via.placeholder.com/150";

  String name = "Loading...";

  String email = "Loading...";

  String profileImageUrl = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>;
          setState(() {
            name = data['name'] ?? "No Name";
            email = data['email'] ?? "No Email";
            profileImageUrl = data['profileImage'] ?? ""; // Ensure profileImageUrl is retrieved
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<DocumentSnapshot> getCurrentUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    } else {
      throw Exception("No user logged in");
    }
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase logout
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login2()), // Redirect to login
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: ${e.toString()}")),
      );
    }
  }

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
          style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF414141))),
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
        children: [ // User Account Header
          UserAccountsDrawerHeader(
            accountName: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(name,
                  style: GoogleFonts.roboto(
                      color: const Color(0xFF414141),
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            accountEmail: Text(email,
                style: GoogleFonts.roboto(
                    color: const Color(0xFF414141),
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            currentAccountPicture:CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: profileImageUrl.isNotEmpty
                  ? NetworkImage(profileImageUrl) as ImageProvider
                  : null,
              child: profileImageUrl.isEmpty ? const Icon(Icons.person, size: 50) : null,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 5),
            child: Text(
              'Personal',
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF414141)),
            ),
          ), // Menu Items
          _buildMenuListTile(
            icon: Icons.person,
            title: 'My Profile',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoScreen()));
            },
          ),
          const SizedBox(height: 4),

          _buildMenuListTile(
            icon: Icons.favorite_outline,
            title: 'My Favourites',
            onTap: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) =>const Wishlist()));
            },
          ),
          const SizedBox(height: 4),
          const Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          const SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.calculate,
            title: 'EMI Calculator',
            onTap: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => const EMICalculatorScreen()));
            },
          ),

          const SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.newspaper,
            title: 'News',
            onTap: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) =>const News()));
            },
          ),
          const SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.share,
            title: 'Share App',
            onTap: () {},
          ),
          const SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.reviews,
            title: 'Testimonials',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Testimonials()));
            },
          ),
          const SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.question_answer,
            title: 'Frequently Asked Questions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              );
            },
          ),
          const SizedBox(height: 4),
          _buildMenuListTile(
            icon: Icons.policy,
            title: 'Policies',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PoliciesScreen()),
              );
            },
          ),
          const SizedBox(height: 4),
          const Divider(
            color: Colors.grey,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          const SizedBox(height: 4),
// Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF0A2472), size: 20),
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xFF0A2472)),
            ),
            onTap: () => _logout(context), // Calls logout function
          ),
        ],
      ),
    );
  }
}



class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getCurrentUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("No user data found"));
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;
        String name = userData['name'] ?? "No Name";
        String email = userData['email'] ?? "No Email";

        return Text("Name: $name\nEmail: $email", style: TextStyle(fontSize: 18));
      },
    );
  }

  Future<DocumentSnapshot> getCurrentUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    } else {
      throw Exception("No user logged in");
    }
  }
}
