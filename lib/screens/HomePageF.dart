import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tractors24/screens/AllBrands.dart';
import 'package:tractors24/screens/AllItems.dart';
import 'package:tractors24/screens/Grids/Brand_Grids.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/Grids/StatesGrids.dart';
import 'package:tractors24/screens/Seller_Form.dart';
import 'package:tractors24/screens/faq_list.dart';
import 'package:tractors24/screens/notification.dart';
import 'package:tractors24/screens/search.dart';

class HomePageF extends StatefulWidget {
  const HomePageF({super.key});

  @override
  State<HomePageF> createState() => _HomePageFState();
}

class _HomePageFState extends State<HomePageF> {
  String _currentAddress = "Loading...";
  Position? _currentPosition;
  String? _pincode = "Fetching...";
  String? _locality = "Fetching...";
  String? _district = "Fetching...";
  String? _state = "Fetching...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() => _currentPosition = position);
      await _getAddressFromLatLng();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _getAddressFromLatLng() async {
    if (_currentPosition == null) return;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      print(place);
      setState(() {
        _currentAddress =
            place.locality ?? place.subAdministrativeArea ?? "Unknown location";
        _pincode = place.postalCode;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Stack(children: [
                  CarouselSlider(
                      items: [
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/first_carou.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/car2_page.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/car3_page.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                      options: CarouselOptions(
                          height: size.height * 0.37,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3))),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, left: 0.0),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: const Image(
                                    image:
                                        AssetImage("assets/images/grp29.png")),
                              ),
                            ),
                            SizedBox(
                              height: 45,
                              width: size.width * 0.5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => search(),
                                    ), // Navigate to your new page
                                  );
                                },
                                child: AbsorbPointer(
                                  // Prevents user input in this TextField
                                  child: TextField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Search Tractor',
                                      hintStyle: GoogleFonts.roboto(
                                        color: Colors.grey[400],
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5, right: 3),
                              child: Image(
                                image: AssetImage("assets/images/location.png"),
                                height: 18,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _currentAddress,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                    ],
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.34),
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.03,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22))),
                  ),
                ),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 0, bottom: 8),
                    child: Text(
                      '|  Recently Added Tractor',
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridViewBuilderWidget(
                    category: 'recently-listed',
                    itemCount: 4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                          body: GridViewBuilderWidget(
                                        category: 'recently-listed',
                                        itemCount: 50,
                                      ))));
                        },
                        child: Image(
                          image: AssetImage("assets/images/seeImg.png"),
                          height: 26,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                    child: Text(
                      '|  Popular Tractor',
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridViewBuilderWidget(
                    category: "popular",
                    itemCount: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                      body: GridViewBuilderWidget(
                                        category: 'popular',
                                        itemCount: 50,
                                      ))));
                        },
                        child: Image(
                          image: AssetImage("assets/images/seeImg.png"),
                          height: 26,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0),
                    child: Container(
                      height: 132,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/BgImg.png"))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Are You Looking For a Tractor ?",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                             Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Scaffold(
                                      body: GridViewBuilderWidget(
                                        category: 'recently-listed',
                                        itemCount: 50,
                                      ))));
                                },
                                child: Image(
                                  image:
                                      AssetImage("assets/images/clkButton.png"),
                                  height: 35,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                    child: Text(
                      '|  Recommend Tractor',
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridViewBuilderWidget(
                    category: "recommended",
                    itemCount: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                          body: GridViewBuilderWidget(
                                        category: 'recommended',
                                        itemCount: 50,
                                      ))));
                        },
                        child: Image(
                          image: AssetImage("assets/images/seeImg.png"),
                          height: 26,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                    child: Text(
                      '|  Certified Tractor',
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridViewBuilderWidget(
                    category: "recently-listed",
                    itemCount: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                          body: GridViewBuilderWidget(
                                        category: 'recently-listed',
                                        itemCount: 50,
                                      ))));
                        },
                        child: Image(
                          image: AssetImage("assets/images/seeImg.png"),
                          height: 26,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 20, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '|  Brand',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFF414141),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BrandsPage()));
                            },
                            child: Text(
                              'See More',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF003B8F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),
                  BrandGrids(
                    itemCount: 8,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 25, right: 16, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '|  Blog & Videos',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFF414141),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const News()));
                            },
                            child: Text(
                              'See More',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF003B8F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 300, // Keep height fixed for horizontal scrolling
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("news")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // Loading state
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Text(
                                  "No news available")); // Handle empty state
                        }

                        return ListView(
                          scrollDirection:
                              Axis.horizontal, // Enable horizontal scrolling
                          children: snapshot.data!.docs.map((doc) {
                            return Container(
                              width: 250,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white
                                        .withOpacity(0.1), // Soft shadow
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset:
                                    const Offset(2, 4), // Slight bottom shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: Image.network(
                                      doc['image'], // Fetch image from Firestore
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['title'], // Fetch title from Firestore
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(height: 5),
                                        Text.rich(
                                          TextSpan(
                                            text: doc[
                                                'content'], // Fetch content from Firestore
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          maxLines: 3, // Display only 2 lines
                                          overflow: TextOverflow
                                              .ellipsis, // Add "..."
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 20, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '|  Search Tractor By State',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFF414141),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> StateGrids()));
                              },
                              child: Text(
                                'See More',
                                style: GoogleFonts.roboto(
                                    color: const Color(0xFF003B8F),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  StateGrids(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 0),
                    child: Container(
                      height: 132,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/BgImg.png"))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerformScreen() ));
    },
                                child: Image(
                                  image:
                                      AssetImage("assets/images/clkButton.png"),
                                  height: 35,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Do You Want to Sell a Tractor ?",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 20, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '| Testimonial',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFF414141),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'See More',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF003B8F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 270, // Fixed height for horizontal scrolling
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("YourCollection")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("No data available"));
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((doc) {
                            return Container(
                              width: 250,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image Section
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    child: Image.network(
                                      doc['imageUrl'],
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                              Icons.broken_image,
                                              size: 150,
                                              color: Colors.grey),
                                    ),
                                  ),

                                  // Text Section
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title
                                        Text(
                                          doc['title'],
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),

                                        // Content (First 2 lines + "...")
                                        Text(
                                          doc['content'],
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  // FAQScreen(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 30, right: 16),
                    child: Text(
                      "FAQ's",
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, right: 15, left: 15),
                    child: Text(
                      "Question Commonly Asked by Buyer's and Seller",
                      style: GoogleFonts.roboto(
                          color: const Color(0xFF414141),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const FAQList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
