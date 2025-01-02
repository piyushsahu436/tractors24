import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tractors24/login_page.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  Widget _buildMainContent() {
    final String sellerId = firebaseAuth.currentUser?.uid ?? '';

    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection('tractors24').doc(sellerId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(
            child: Text(
              'No vehicles added yet.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final List<dynamic> vehicles = snapshot.data!['vehicles'] ?? [];

        if (vehicles.isEmpty) {
          return const Center(
            child: Text(
              'No vehicles added yet.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];

            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.asset(
                      'assets/Tractors.png',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle['brandName'],
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text('Description: ${vehicle['description']}',
                            style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
                        Text('Horsepower: ${vehicle['horsePower']} HP',
                            style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
                        Text('Insurance: ${vehicle['insuranceSecurity']}',
                            style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
                        Text('Sell Price: ₹${vehicle['sellPrice']}',
                            style: const TextStyle(fontSize: 16.0, color: Colors.black,)),
                        const SizedBox(height: 8.0),
                        // Text(
                        //   'Added on: ${vehicle['timestamp'] != null ? (vehicle['timestamp'] as Timestamp).toDate().toString() : "Unknown"}',
                        //   style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProfilePage() {
    final User? currentUser = firebaseAuth.currentUser;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(height: 20),
                  ListTile(
                    leading: const Icon(Icons.person_outline, color: Colors.blue),
                    title: const Text('Name'),
                    subtitle: Text(
                      currentUser?.displayName ?? 'Not set',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined, color: Colors.blue),
                    title: const Text('Email'),
                    subtitle: Text(
                      currentUser?.email ?? 'Not set',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone_outlined, color: Colors.blue),
                    title: const Text('Phone Number'),
                    subtitle: Text(
                      currentUser?.phoneNumber ?? 'Not set',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsPage() {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Account Settings'),
          onTap: () {
            // Handle account settings
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text('Notifications'),
          onTap: () {
            // Handle notifications
          },
        ),
        ListTile(
          leading: const Icon(Icons.security_outlined),
          title: const Text('Vehicle Security'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VehicleDetailsForm()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () => _logout(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildMainContent(),
      _buildProfilePage(),
      _buildSettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tractors24 ${_selectedIndex == 0 ? "Home" : _selectedIndex == 1 ? "Profile" : "Settings"}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () => _showAddVehicleDialog(context, firebaseAuth.currentUser?.uid ?? ''),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      )
          : null,
    );
  }

  void _showAddVehicleDialog(BuildContext context, String sellerId) {
    final TextEditingController brandNameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController horsePowerController = TextEditingController();
    final TextEditingController insuranceSecurityController = TextEditingController();
    final TextEditingController sellPriceController = TextEditingController();

    // Retrieve additional user details
    final User? currentUser = firebaseAuth.currentUser;
    final String email = currentUser?.email ?? '';
    final String name = currentUser?.displayName ?? 'Unknown';
    final String phone = currentUser?.phoneNumber ?? 'Unknown';
    const String userType = "seller"; // Define the user type manually or retrieve from Firestore.

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Vehicle'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: brandNameController,
                  decoration: const InputDecoration(labelText: 'Brand Name'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: horsePowerController,
                  decoration: const InputDecoration(labelText: 'Horsepower (HP)'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: insuranceSecurityController,
                  decoration: const InputDecoration(labelText: 'Insurance Security'),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: sellPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Sell Price'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String brandName = brandNameController.text.trim();
                final String description = descriptionController.text.trim();
                final String horsePower = horsePowerController.text.trim();
                final String insuranceSecurity = insuranceSecurityController.text.trim();
                final String sellPrice = sellPriceController.text.trim();

                if (brandName.isEmpty ||
                    description.isEmpty ||
                    horsePower.isEmpty ||
                    insuranceSecurity.isEmpty ||
                    sellPrice.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                  return;
                }

                try {
                  // Add vehicle details along with user info
                  final DocumentReference sellerRef =
                  firestore.collection('tractors24').doc(sellerId);

                  await sellerRef.set({

                    'vehicles': FieldValue.arrayUnion([
                      {
                        'brandName': brandName,
                        'description': description,
                        'horsePower': horsePower,
                        'insuranceSecurity': insuranceSecurity,
                        'sellPrice': sellPrice,
                        // Add current time
                      }
                    ])
                  }, SetOptions(merge: true)); // Merge if the document already exists

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vehicle added successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add vehicle: $e')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}



