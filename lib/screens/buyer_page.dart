import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/ContactInfo.dart';
import 'package:tractors24/screens/DetailsPage.dart';

import 'emi_cal.dart';

class BuyerScreen extends StatefulWidget {
  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

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
        final userDoc =
            await firestore.collection('tractors24').doc(user.uid).get();
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

  Widget _buildHomeScreen() {
    Size size = MediaQuery.of(context).size;
    int selectedIndex = 0;
    final List<Map<String, dynamic>> vehicleCategories = [
      {'icon': Icons.local_shipping, 'label': 'Truck'},
      {'icon': Icons.construction, 'label': 'Equipment'},
      {'icon': Icons.directions_bus, 'label': 'Bus'},
      {'icon': Icons.agriculture, 'label': 'Tractor'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 8),
                  child: Text(
                    "Let's Find your ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 4, 0, 7),
                  child: Row(
                    children: [
                      Text(
                        "Dream Tractor",
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        " now!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9.0),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                borderWidth: 1.5,
                borderColor: Colors.blue[200],
                selectedBorderColor: Colors.blue[200],
                fillColor: Colors.blue[200],
                selectedColor: Colors.white,
                disabledColor: Colors.blue[200],
                color: Colors.blue[200],
                constraints: const BoxConstraints(minWidth: 70, minHeight: 32),
                isSelected: [selectedIndex == 0, selectedIndex == 1],
                onPressed: (int index) {
                  setState(() {
                    selectedIndex = index; // Update the selected index
                  });
                },
                children: const [
                  Text('New', style: TextStyle(fontSize: 16)),
                  Text('Used', style: TextStyle(fontSize: 16)),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: vehicleCategories.map((category) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.blue.shade200, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white, // Light blue background
                    ),
                    child: Icon(
                      category['icon'],
                      color: Colors.blue[200],
                      size: 30, // Uniform icon size
                    ),
                  ),
                  const SizedBox(height: 8), // Space between icon and label
                  Text(
                    category['label'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12, // Uniform text size
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: size.height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Select your Tractor name',
                      filled: false,
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.grey.shade400,width: 1)
                      // ),
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0, right: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        String query = _searchController.text;
                        print('Searching for: $query');
                      },
                      style: ElevatedButton.styleFrom(
                          // fixedSize:,
                          backgroundColor: Colors.blue[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11))),
                      child: const Text('Find Tractor',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  final vehicles =
                      (doc.data() as Map<String, dynamic>)['vehicles']
                              as List<dynamic>? ??
                          [];

                  if (vehicles.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...vehicles.map((vehicle) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CarDetailsPage()));
                            },
                            child: Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10.0)),
                                    child: Image.asset(
                                      'assets/banner1.jpg',
                                      height: 150,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vehicle['brandName'] ?? 'Mahindra Go',
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        const Text(
                                          'Mahindra',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                height: size.height * 0.03,
                                                width: size.width * 0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: const Center(
                                                  child: Text(
                                                    "2022",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                )),
                                            Container(
                                                height: size.height * 0.03,
                                                width: size.width * 0.22,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: const Center(
                                                  child: Text(
                                                    "450000 kms",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                )),
                                            Container(
                                                height: size.height * 0.03,
                                                width: size.width * 0.11,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: const Center(
                                                  child: Text(
                                                    "Petrol",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                )),
                                            Container(
                                                height: size.height * 0.03,
                                                width: size.width * 0.14,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: const Center(
                                                  child: Text(
                                                    "566 HP",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                )),
                                            const SizedBox(
                                              width: 80,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        // Text(
                                        //   ' ${vehicle['description'].toString().toUpperCase() ?? 'TATA'}',
                                        //   style: const TextStyle(fontSize: 16.0),
                                        // ),
                                        // Text(
                                        //   'Horsepower: ${vehicle['horsePower'] ?? ''} HP',
                                        //   style: const TextStyle(fontSize: 16.0),
                                        // ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text(
                                            //   'Insurance: ${vehicle['insuranceSecurity'] ?? ''}',
                                            //   style: const TextStyle(fontSize: 16.0),
                                            // ),
                                            Text(
                                              '₹${vehicle['sellPrice'] ?? ''}',
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    (context),
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ContactSellerScreen())); // Handle button press
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue[300],
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              child:
                                                  const Text('Contact Seller'),
                                            )
                                          ],
                                        ),
                                        // Text(
                                        //   'Price: ₹${vehicle['sellPrice'] ?? ''}',
                                        //   style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                                        // ),
                                        // const SizedBox(height: 8.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }

  Widget _buildProfileScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              userPhoto ?? 'https://via.placeholder.com/150',
            ),
            backgroundColor: Colors.blue,
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
                    leading:
                        const Icon(Icons.person_outline, color: Colors.blue),
                    title: const Text('Name'),
                    subtitle: Text(
                      userName ?? 'Guest User',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.email_outlined, color: Colors.blue),
                    title: const Text('Email'),
                    subtitle: Text(
                      auth.currentUser?.email ?? 'No email set',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.phone_outlined, color: Colors.blue),
                    title: const Text('Phone Number'),
                    subtitle: Text(
                      auth.currentUser?.phoneNumber ?? 'No phone number set',
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomeScreen(),
      EMICalculatorScreen(),
      _buildProfileScreen(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: _selectedIndex == 0
            ? const Size.fromHeight(240)
            : const Size.fromHeight(80),
        child: AppBar(
            backgroundColor: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: _selectedIndex == 0
                ? Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://img.pikbest.com/wp/202402/tractor-3d-illustration-of-high-tech-farm-constructed-with-luminescent-points-and-lines_9825055.jpg!w700wp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : null,
            title: _selectedIndex == 0
                ? null
                : Center(
                    child: Text(
                      _selectedIndex == 1
                          ? 'EMI Calculator'
                          : 'Profile Screen ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            actions: _selectedIndex == 0
                ? [
                    const Padding(
                      padding: EdgeInsets.only(right: 10, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Indore',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  ]
                : null),
      ),
      drawer: _selectedIndex == 0
          ? Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.lightBlue),
                    accountName: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        userName ?? 'Guest',
                        style: const TextStyle(fontSize: 18),
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
                    leading: const Icon(Icons.person),
                    title: const Text('My Profile'),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calculate),
                    title: const Text('EMI Calculator'),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
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
            )
          : null,
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
            icon: Icon(Icons.calculate),
            label: 'EMI Calc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
