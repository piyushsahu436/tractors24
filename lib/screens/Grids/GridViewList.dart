import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/contact_seller.dart';

class GridViewBuilderWidget extends StatelessWidget {
  GridViewBuilderWidget(
      {super.key,
      required this.itemCount,
      required this.category,
      required this.scrolled});
  final int itemCount;
  final String category;
  final ScrollPhysics scrolled;
  final CollectionReference tractorsCollection =
      FirebaseFirestore.instance.collection('tractors');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: tractorsCollection
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          var tractors = snapshot.data!.docs;

          return GridView.builder(
            shrinkWrap: true,
            physics: scrolled,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 0.59,
            ),
            itemCount:
                itemCount > tractors.length ? tractors.length : itemCount,
            itemBuilder: (context, index) {
              var tractor = tractors[index].data() as Map<String, dynamic>;
              var docSnapshot = snapshot.data!.docs[index];
              String docId = docSnapshot.id;
              List<String> imageUrls = (tractor['images'] as List<dynamic>?)
                      ?.map((e) => e.toString())
                      .toList() ??
                  [];
              // var tid  = tractorsCollection.doc().get();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarDetailsPage(
                                SellPrice:
                                    tractor['expectedPrice']?.toString() ?? '',
                                brand: tractor['brand'] ?? '',
                                model: tractor['model'] ?? '',
                                RegYear: tractor['registrationYear'] ?? '',
                                Pincode: tractor['pincode']?.toString() ?? '',
                                HorsePower:
                                    tractor['horsePower']?.toString() ?? '',
                                Hours: tractor['hoursDriven'] ?? '',
                                RegNum: tractor['registrationNumber'] ?? '',
                                InsStatus: tractor['insuranceStatus'] ?? '',
                                RearTire: tractor['rearTyreSize'] ?? '',
                                Address: tractor['location'] ?? '',
                                Break: tractor['brakes'] ?? '',
                                PTO: tractor['ptoHP'] ?? '',
                                CC: tractor['capacityCC'] ?? '',
                                Cooling: tractor['coolingSystem'] ?? '',
                                LiftingCapacity:
                                    tractor['liftingCapacity'] ?? '',
                                SteeringType: tractor['steeringType'] ?? '',
                                ClutchType: tractor['Clutch Type'] ?? '',
                                OilCap: tractor['capacity'] ?? '',
                                RunningKM: tractor['Running KM'] ?? '',
                                Fuel: tractor['fuelType'] ?? '',
                                tractorId: tractor['tractorId'] ?? '',
                                imageUrls: (tractor['images'] as List<dynamic>?)
                                        ?.map((e) => e.toString())
                                        .toList() ??
                                    [],
                                description: tractor['description'] ?? '',
                                state: tractor['state'] ?? "",
                                safetyfeature: tractor['safetyFeatures'] ?? "",
                                warrenty: tractor['warranty'] ?? "",
                                color: tractor['color'] ?? "",
                                accessories: tractor['accessories'] ?? "",
                                rpm: tractor['rpm'] ?? "",
                                ptodirection: '' ?? "",
                                battery: tractor['battery'] ?? "",
                                cylinder: tractor['noOfCylinders'] ?? "",
                                gearbox: tractor['gearBox'] ?? "",
                                torque: '' ?? "",
                                fronttyre: tractor['frontTyreSize'],
                                clutch: tractor['clutch'] ?? "",
                                pincode: tractor['pincode'] ?? " ",
                                docId: docId,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: Container(
                          height: size.height * 0.15,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.0)),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Blurred Background Image
                              if (imageUrls.isNotEmpty)
                                ImageFiltered(
                                  imageFilter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Image.network(
                                    imageUrls[0],
                                    fit: BoxFit.cover,
                                    color: Colors.black.withOpacity(0.3),
                                    colorBlendMode: BlendMode.darken,
                                  ),
                                ),

                              // Foreground Image with Proper Fit
                              Center(
                                child: Image.network(
                                  imageUrls.isNotEmpty
                                      ? imageUrls[0]
                                      : 'assets/images/default.png',
                                  fit: BoxFit.contain, // Keeps aspect ratio
                                  width: size.width *
                                      0.9, // Adjust width as needed
                                  height: size.height * 0.15, // Adjust height
                                ),
                              ),

                              // Other UI Elements (Labels, Favorite Icon, etc.)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF003B8F),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              " Great Price ",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            try {
                                              // Get the current user's ID
                                              String userId = FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      ?.uid ??
                                                  'unknown_user';
                                              String tractorId =
                                                  tractors[index].id;

                                              CollectionReference wishlistRef =
                                                  FirebaseFirestore.instance
                                                      .collection('wishlists');

                                              // Save data in Firestore
                                              await wishlistRef
                                                  .doc('$userId-$tractorId')
                                                  .set({
                                                'userId': userId,
                                                'tractorId': tractorId,
                                                'timestamp': FieldValue
                                                    .serverTimestamp(),
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Added to Wishlist!')),
                                              );
                                            } catch (e) {
                                              print(
                                                  "Error adding to wishlist: $e");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Failed to add to Wishlist!')),
                                              );
                                            }
                                          },
                                          child: const Image(
                                            image: AssetImage(
                                                "assets/images/favIcon.png"),
                                            height: 22.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Title
                            Text(
                              '${tractor['brand']} ${tractor['model']}',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF050B20),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: size.height * 0.007),

                            // Location and KM Info
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/locaIcon.png"),
                                        height: 12,
                                      ),
                                      SizedBox(width: size.width * 0.015),
                                      Text(
                                        tractor['location'] ?? 'Unknown',
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xFF414141),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: size.width * 0.015),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/kmIcon.png"),
                                        height: 9,
                                      ),
                                      SizedBox(width: size.width * 0.015),
                                      Text(
                                        '${tractor['hoursDriven']} hr' ??
                                            'Unknown',
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xFF414141),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.007),

                            // Price
                            Text(
                              '₹${tractor['expectedPrice']}' ?? 'Unknown',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF414141),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            // Contact Button
                            SizedBox(height: size.height * 0.007),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactSellerScreen(
                                        imageUrls: (tractor['images'] as List<dynamic>?)
                                          ?.map((e) => e.toString())
                                          .toList() ??
                                          [],
                                        docid: docId,
                                        brand: '${tractor['brand']}',
                                        price: '${tractor['expectedPrice']}',
                                        location:
                                            tractor['location'] ?? 'Unknown',
                                        model: ' ${tractor['model']}',
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF003B8F),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Contact Seller',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ImageSliderWidget extends StatefulWidget {
  final List<String>? imageUrls;

  const ImageSliderWidget({super.key, this.imageUrls});

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.25,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls?.length ?? 1, // Avoid null error
            itemBuilder: (context, index) {
              if (widget.imageUrls == null || widget.imageUrls!.isEmpty) {
                return defaultImageSlider(); // Default image when no URLs are available
              }

              String imageUrl = widget.imageUrls![index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Blurred Background Image
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),

                  // Foreground Image with Proper Fit
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain, // Maintains aspect ratio
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: size.height * 0.25,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return defaultImage();
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Smooth Page Indicator
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.imageUrls?.length ?? 1,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Color(0xFF003B8F),
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget defaultImageSlider() {
    return Column(
      children: [
        SizedBox(height: 200, child: defaultImage()),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: PageController(),
          count: 1,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.blue,
            dotColor: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget defaultImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/Rectangle 23807.png',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
