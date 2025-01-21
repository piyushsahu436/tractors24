import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/ContactInfo.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/drawer.dart';
import 'package:tractors24/screens/recommedWidget.dart';
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

  Widget _buildHomeScreen() {
    Size size = MediaQuery.of(context).size;
    int selectedIndex = 0;
    final List<Map<String, dynamic>> vehicleCategories = [
      {'icon': Icons.local_shipping, 'label': 'Truck'},
      {'icon': Icons.construction, 'label': 'Equipment'},
      {'icon': Icons.directions_bus, 'label': 'Bus'},
      {'icon': Icons.agriculture, 'label': 'Tractor'},
    ];

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                            fontWeight: FontWeight.w500
                        ),
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
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const Text(
                            " now!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
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
                        selectedIndex = index;
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
                          border: Border.all(color: Colors.blue.shade200, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Icon(
                          category['icon'],
                          color: Colors.blue[200],
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['label'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
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
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Select your Tractor name',
                          filled: false,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          String query = _searchController.text;
                          print('Searching for: $query');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)
                            )
                        ),
                        child: const Text(
                            'Find Tractor',
                            style: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    physics: BouncingScrollPhysics(),
                    isScrollable: true,
                    tabs: [
                      Tab(text: "Recommended"),
                      Tab(text: "Recently Added"),
                      Tab(text: "Popular"),
                      Tab(text: "Certified"),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.6,
                    child: TabBarView(
                      children: [
                        Recommend(size: size),
                        Center(child: Text("Recently Added")),
                        Center(child: Text("Popular")),
                        Center(child: Text("Certified")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Center(
                child: Text("Profile" , style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),),
              ),
            ),
          ),
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
                    leading: const Icon(Icons.person_outline, color: Colors.blue),
                    title: const Text('Name'),
                    subtitle: Text(
                      userName ?? 'Guest User',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_outlined, color: Colors.blue),
                    title: const Text('Email'),
                    subtitle: Text(
                      auth.currentUser?.email ?? 'No email set',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone_outlined, color: Colors.blue),
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
      NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.blue,
              expandedHeight: 50,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://img.pikbest.com/wp/202402/tractor-3d-illustration-of-high-tech-farm-constructed-with-luminescent-points-and-lines_9825055.jpg!w700wp'
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Indore',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ];
        },
        body: _buildHomeScreen(),
      ),
      EMICalculatorScreen(),
      _buildProfileScreen(),
    ];

    return Scaffold(
      drawer: _selectedIndex == 0 ? const CustomDrawer() : null,
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