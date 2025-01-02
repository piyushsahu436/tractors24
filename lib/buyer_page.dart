import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tractors24/login_page.dart';


class BuyerScreen extends StatefulWidget {
  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? userType;
  String? userName;
  String? userPhoto;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        final userDoc = await firestore.collection('tractors24').doc(user.uid).get();
        if (userDoc.exists) {
          final userData = userDoc.data();
          setState(() {
            userType = userData?['userType'];
            userName = userData?['name'].toString();
            userPhoto = userData?['photoURL'];
          });
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }


  Future<void> _addToCart(Map<String, dynamic> vehicle) async {
    try {
      final String userId = auth.currentUser?.uid ?? '';
      await firestore.collection('cart').add({
        'userId': userId,
        'brandName': vehicle['brandName'],
        'description': vehicle['description'],
        'horsePower': vehicle['horsePower'],
        'sellPrice': vehicle['sellPrice'],
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${vehicle['brandName']} added to cart')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90), // Adjust the height of the AppBar
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // Set the drawer icon color
          ),

          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/banner2.jpeg'),
                fit: BoxFit.cover, // Ensures the image covers the entire area
              ),
            ),
          ),
          title: const Text(
            'The Prefect Tractors \n Wheels your dreams ',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold ),
          ),

        ),
      ),
      drawer: Drawer(

        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              accountName: Padding(
                padding: const EdgeInsets.only(top: 20.0), // Add padding for spacing
                child: Text(
                  userName ?? 'Guest',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              accountEmail: Text(auth.currentUser?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  userPhoto ?? 'https://via.placeholder.com/150',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('My Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              title: Text('My Subscription'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Let's Find your ",
            style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 7),
          child: Text(
            "dream Tractor now!",
            style: TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Type to Select Your Tractor Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    String query = _searchController.text;
                    // Handle search logic here
                    print('Searching for: $query');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Find Tractor', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
        // Add ListView.builder under Column
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('tractors24').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No vehicles available.',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, docIndex) {
                  final doc = snapshot.data!.docs[docIndex];
                  final vehicles = (doc.data() as Map<String, dynamic>)['vehicles'] as List<dynamic>? ?? [];
                  final sellerPhone = (doc.data() as Map<String, dynamic>)['phone'] ?? 'N/A';

                  if (vehicles.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...vehicles.map((vehicle) => Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                              child: Image.asset(
                                'assets/Tractors.png',
                                height: 150,
                                width: MediaQuery.of(context).size.width*0.9,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle['brandName'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Description: ${vehicle['description'].toString().toUpperCase() ?? ''}',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  Text(
                                    'Horsepower: ${vehicle['horsePower'] ?? ''} HP',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Insurance: ${vehicle['insuranceSecurity'] ?? ''}',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Handle button press
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue, // Background color
                                          foregroundColor: Colors.white, // Text color
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Optional: Adjust padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners
                                          ),
                                        ),
                                        child: const Text('Contact Seller'),
                                      )

                                    ],
                                  ),
                                  Text(
                                    'Price: ₹${vehicle['sellPrice'] ?? ''}',
                                    style: const TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  const SizedBox(height: 8.0),
                                  // ElevatedButton(
                                  //   onPressed: () => _addToCart(vehicle),
                                  //   style: ElevatedButton.styleFrom(
                                  //     backgroundColor: Colors.teal,
                                  //     minimumSize: const Size(double.infinity, 36),
                                  //   ),
                                  //   child: const Text('Add to Cart'),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    ),

    );
  }
}