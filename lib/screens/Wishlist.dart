import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Vector8.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 45.0, left: 8),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Aligns items from the start
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Favourites',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            Favourites(),
          ],
        ),
      ),
    );
  }
}

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Center(child: Text("User not authenticated!"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wishlists')
            .where('userId', isEqualTo: uid) // Correct filter
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No wishlist items found"));
          }

          var wishlistDocs = snapshot.data!.docs;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: wishlistDocs.length,
            itemBuilder: (context, index) {
              var wishlistData =
                  wishlistDocs[index].data() as Map<String, dynamic>;
              String tractorId = wishlistData['tractorId'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('tractors')
                    .doc(tractorId)
                    .get(),
                builder: (context, tractorSnapshot) {
                  if (tractorSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!tractorSnapshot.hasData ||
                      !tractorSnapshot.data!.exists) {
                    return const Center(child: Text("Tractor not found"));
                  }

                  var tractor =
                      tractorSnapshot.data!.data() as Map<String, dynamic>;
                  List<String> imageUrls = (tractor['images'] as List<dynamic>?)
                          ?.map((e) => e.toString())
                          .toList() ??
                      [];
                  var docSnapshot = snapshot.data!.docs[index];
                  String docId = docSnapshot.id;

                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarDetailsPage(
                                      SellPrice: tractor['expectedPrice']
                                              ?.toString() ??
                                          '',
                                      brand: tractor['brand'] ?? '',
                                      model: tractor['model'] ?? '',
                                      RegYear:
                                          tractor['registrationYear'] ?? '',
                                      Pincode:
                                          tractor['pincode']?.toString() ?? '',
                                      HorsePower:
                                          tractor['horsePower']?.toString() ??
                                              '',
                                      Hours: tractor['hoursDriven'] ?? '',
                                      RegNum:
                                          tractor['registrationNumber'] ?? '',
                                      InsStatus:
                                          tractor['insuranceStatus'] ?? '',
                                      RearTire: tractor['rearTyreSize'] ?? '',
                                      Address: tractor['location'] ?? '',
                                      Break: tractor['brakes'] ?? '',
                                      PTO: tractor['ptoHP'] ?? '',
                                      CC: tractor['capacityCC'] ?? '',
                                      Cooling: tractor['coolingSystem'] ?? '',
                                      LiftingCapacity:
                                          tractor['liftingCapacity'] ?? '',
                                      SteeringType:
                                          tractor['steeringType'] ?? '',
                                      ClutchType: tractor['Clutch Type'] ?? '',
                                      OilCap: tractor['capacity'] ?? '',
                                      RunningKM: tractor['Running KM'] ?? '',
                                      Fuel: tractor['fuelType'] ?? '',
                                      tractorId: tractor['tractorId'] ?? '',
                                      imageUrls:
                                          (tractor['images'] as List<dynamic>?)
                                                  ?.map((e) => e.toString())
                                                  .toList() ??
                                              [],
                                      description: tractor['description'] ?? '',
                                      state: tractor['state'] ?? "",
                                      safetyfeature:
                                          tractor['safetyFeatures'] ?? "",
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
                                    )
                            )
                        );
                      },
                      child: Column(
                        children: [
                          Slidable(
                            key: ValueKey(
                                docId), // Use a unique key for each item
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                CustomSlidableAction(
                                  onPressed: (context) async {
                                    await FirebaseFirestore.instance
                                        .collection('wishlists')
                                        .doc(docId)
                                        .delete();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Item removed from wishlist")),
                                    );
                                  },
                                  backgroundColor: Colors
                                      .white, // Background color of the button
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            child: Container(
                              height: size.height * 0.17,
                              width: size.width * 0.9,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                    child: imageUrls.isNotEmpty
                                        ? Image.network(
                                            imageUrls[0],
                                            width: size.width * 0.45,
                                            height: size.height * 0.17,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/tracTemp.png",
                                            width: size.width * 0.45,
                                            height: size.height * 0.17,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${tractor['brand']} ${tractor['model']}',
                                            style: GoogleFonts.anybody(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                child: Text(
                                                  tractor['location'] ??
                                                      'Unknown',
                                                  style: GoogleFonts.anybody(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 10,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Icon(Icons.speed,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  '${tractor['hoursDriven']} hr' ??
                                                      'Unknown',
                                                  style: GoogleFonts.anybody(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),f
                                          const SizedBox(height: 5),
                                          Expanded(
                                            child: Text(
                                              '₹${tractor['expectedPrice']}' ??
                                                  'Unknown',
                                              style: GoogleFonts.anybody(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
