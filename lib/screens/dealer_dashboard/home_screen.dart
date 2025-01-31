import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tractors24/screens/dealer_dashboard/profile_screen.dart';
import 'package:tractors24/screens/dealer_dashboard/referral_screen.dart';
import 'package:tractors24/screens/dealer_dashboard/rto_screen.dart';

import '../customer_inquiries_screen.dart';

class DealerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Tractor',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100], // Grey background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),


      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://example.com/profile.jpg'),
                backgroundColor: Color(0xFF0D5CA2),// Replace with actual image
              ),
              accountName: Text(
                'Dealer Dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                    color: Color(0xFF0D5CA2),
                ),
              ),
              accountEmail: Text(
                'Abc@gmail.com',
                style: TextStyle(
                  fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D5CA2)
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
              height: 1,
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(Icons.car_repair, 'Stock Tracking', () {}),
                  _buildDrawerItem(Icons.assignment, 'RTO Management', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RtoManagementApp()),
                    );
                  }),
                  _buildDrawerItem(Icons.attach_money, 'Payment & Profit', () {}),
                  _buildDrawerItem(Icons.directions_car, 'Vehicle Information', () {}),
                  SizedBox(height: 5,),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 1,
                  ),
                  SizedBox(height: 5,),
                  _buildDrawerItem(Icons.insights, 'Dealer Insights', () {}),
                  _buildDrawerItem(Icons.notifications, 'Notifications', () {}),
                  _buildDrawerItem(Icons.chat, 'Customer Inquiries', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerInquiriesScreen()),
                    );
                  }),
                  _buildDrawerItem(Icons.share, 'Referral System', () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReferralProgramScreen()),
                  );}),
                  _buildDrawerItem(Icons.settings, 'Settings', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  }),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 1,
                  ),
                  _buildDrawerItem(Icons.logout, 'Logout', () {
                    // Implement Logout Functionality
                  }, color: Color(0xFF0D5CA2)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Text("Stock Mangement" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddNewTractorDialog();
                  },
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Add New Tractor' , style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D5CA2), // Primary color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('tractors').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tractors available.'));
                  }

                  final tractorDocs = snapshot.data!.docs;

                  return  ListView.builder(
                    itemCount: tractorDocs.length,
                    itemBuilder: (context, index) {
                      final tractorData = tractorDocs[index].data() as Map<String, dynamic>;
                      final documentId = tractorDocs[index].id; // Get the document ID

                      return TractorCard(
                        name: tractorData['name'] ?? 'Unknown Tractor',
                        location: tractorData['district'] ?? 'Unknown Location',
                        price: tractorData['sellPrice']?.toString() ?? 'N/A',
                        documentId: documentId, // Pass the document ID
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color color = const Color(0xFF0D5CA2)}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}
class TractorCard extends StatelessWidget {
  final String name;
  final String location;
  final String price;
  final String documentId; // Add this to track the Firebase document

  TractorCard({
    required this.name,
    required this.location,
    required this.price,
    required this.documentId,
  });

  // Function to handle tractor deletion
  Future<void> _deleteTractor(BuildContext context) async {
    try {
      // Show confirmation dialog
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this tractor?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      ) ?? false;

      if (confirm) {
        await FirebaseFirestore.instance
            .collection('tractors')
            .doc(documentId)
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tractor deleted successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting tractor: $e')),
      );
    }
  }

  // Function to show edit dialog
  Future<void> _showEditDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController locationController = TextEditingController(text: location);
    final TextEditingController priceController = TextEditingController(text: price);

    try {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Tractor'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Tractor Name'),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection('tractors')
                        .doc(documentId)
                        .update({
                      'name': nameController.text,
                      'district': locationController.text,
                      'sellPrice': priceController.text,
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tractor updated successfully')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error updating tractor: $e')),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error showing edit dialog: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                'assets/images/banner1.jpg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(location, style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      Icon(Icons.speed, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('40,000 KM', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '₹ $price',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showEditDialog(context),
                          child: Text('Edit', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0D5CA2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _deleteTractor(context),
                          child: Text('Delete'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewTractorDialog extends StatefulWidget {
  @override
  State<AddNewTractorDialog> createState() => _AddNewTractorDialogState();
}

class _AddNewTractorDialogState extends State<AddNewTractorDialog> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController registrationYearController = TextEditingController();
  final TextEditingController horsePowerController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  Future<void> addTractor() async {
    try {
      final tractorData = {
        "brand": brandController.text.trim(),
        "name": nameController.text.trim(),
        "model": modelController.text.trim(),
        "registrationNumber": registrationNumberController.text.trim(),
        "registrationYear": registrationYearController.text.trim(),
        "horsePower": horsePowerController.text.trim(),
        "hours": hoursController.text.trim(),
        "category": categoryController.text.trim(),
        "state": stateController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
        "description": "",
        "district": "Pune", // Example: Replace with dynamic input if needed
        "insuranceStatus": "Expired", // Example: Replace with dynamic input if needed
        "listingDate": DateTime.now().toUtc().toIso8601String(),
        "pincode": "411001", // Example: Replace with dynamic input if needed
        "rearTyre": "16.9x28", // Example: Replace with dynamic input if needed
        "sellPrice": "640000", // Example: Replace with dynamic input if needed
        "showroomPrice": "1000000", // Example: Replace with dynamic input if needed
        "status": "active",
        "viewCount": 0,
      };

      await FirebaseFirestore.instance.collection('tractors').add(tractorData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Tractor added successfully!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add tractor: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add New Tractor',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: brandController,
                decoration: InputDecoration(labelText: 'Brand*'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name*'),
              ),
              TextField(
                controller: modelController,
                decoration: InputDecoration(labelText: 'Model*'),
              ),
              TextField(
                controller: registrationNumberController,
                decoration: InputDecoration(labelText: 'Registration Number*'),
              ),
              TextField(
                controller: registrationYearController,
                decoration: InputDecoration(labelText: 'Registration Year*'),
              ),
              TextField(
                controller: horsePowerController,
                decoration: InputDecoration(labelText: 'Horse Power*'),
              ),
              TextField(
                controller: hoursController,
                decoration: InputDecoration(labelText: 'Hours Used*'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category*'),
              ),
              TextField(
                controller: stateController,
                decoration: InputDecoration(labelText: 'State*'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: addTractor,
                    child: Text('Add Tractor'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}











