import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/contact_seller.dart';

class liveFavourites extends StatelessWidget {
  final CollectionReference tractorsCollection =
      FirebaseFirestore.instance.collection('tractors');

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
            .collection('tractors')
            .where('uid', isEqualTo: uid) // Filter by UID
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

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: tractors.length,
            itemBuilder: (context, index) {
              var tractor = tractors[index].data() as Map<String, dynamic>;
              var docSnapshot = snapshot.data!.docs[index];
              String docId =docSnapshot.id;
              List<String> imageUrls = (tractor['images'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ?? [];
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
                            clutch: tractor['clutch']?? "",
                            pincode: tractor['pincode']?? " ",
                            docId: docId,
                          )));
                },
                child: Container(
                  height: size.height * 0.17,
                  width: size.width * 0.8,
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
                        child: Image.asset(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${tractor['brand']} ${tractor['model']}',
                                style: GoogleFonts.roboto(
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
                                      tractor['district'] ?? 'Unknown',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
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
                                      '${tractor['hours']} hr' ?? 'Unknown',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Text(
                                  '₹${tractor['sellPrice']}' ?? 'Unknown',
                                  style: GoogleFonts.roboto(
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
              );
            },
          );
        },
      ),
    );
  }
}

class PersonalAds extends StatefulWidget {
  const PersonalAds({super.key});

  @override
  State<PersonalAds> createState() => _PersonalAdsState();
}

class _PersonalAdsState extends State<PersonalAds> {
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
                padding: const EdgeInsets.only(top: 20.0, left: 8),
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
                        'My Ads',
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
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '|  Approved Ads',
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF414141),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            liveFavourites(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '|  Pending Ads',
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF414141),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            pendingFavourites(),
          ],
        ),
      ),
    );
  }
}

class pendingFavourites extends StatelessWidget {
  pendingFavourites({super.key});

  final CollectionReference tractorsCollection =
      FirebaseFirestore.instance.collection('pendingListings');

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
            .collection('pendingListings')
            .where('uid', isEqualTo: uid) // Filter by UID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              "No Tractors are in Queue.",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  color: Colors.black),
            ));
          }

          var tractors = snapshot.data!.docs;


          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: tractors.length,
            itemBuilder: (context, index) {
              var tractor = tractors[index].data() as Map<String, dynamic>;
              // var tractor =
              // tractorSnapshot.data!.data() as Map<String, dynamic>;
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
                          builder: (context) => //CarDetailsPage()
                          CarDetailsPage(
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
                            imageUrls ?? [],
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
                            fronttyre: tractor['frontTyreSize'] ?? "",
                            clutch: tractor['clutch'] ?? "",
                            pincode: tractor['pincode'] ?? " ",
                            docId: docId ?? '',
                          )));
                },
                child: Container(
                  height: size.height * 0.17,
                  width: size.width * 0.8,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${tractor['brand']} ${tractor['model']}',
                                style: GoogleFonts.roboto(
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
                                      tractor['district'] ?? 'Unknown',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
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
                                      '${tractor['hours']} hr' ?? 'Unknown',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Text(
                                  '₹${tractor['sellPrice']}' ?? 'Unknown',
                                  style: GoogleFonts.roboto(
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
              );
            },
          );
        },
      ),
    );
  }
}
