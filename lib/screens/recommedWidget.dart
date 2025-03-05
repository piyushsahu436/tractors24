import 'package:flutter/material.dart';
import 'package:tractors24/screens/AllItems.dart';
import 'package:tractors24/screens/contact_seller.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recommend extends StatefulWidget {
  final Size size;
  const Recommend({super.key, required this.size});

  @override
  State<Recommend> createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: SizedBox(
        height: size.height * 0.48,
        child: TabBarView(
          physics: const ClampingScrollPhysics(),
          children: [
            buildCustomCard(context),
            buildCustomCard(context),
            buildCustomCard(context),
            buildCustomCard(context), // For Certified Tab
          ],
        ),
      ),
    );
  }
}

Widget buildCustomCard(BuildContext context) {
  final CollectionReference tractorsCollection =
      FirebaseFirestore.instance.collection('tractors');
  Size size = MediaQuery.of(context).size;
  return StreamBuilder<QuerySnapshot>(
    stream: tractorsCollection.snapshots(),
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
      var tractors = snapshot.data!.docs;

      return Column(
        children: [
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 20.0, // Spacing between columns
                mainAxisSpacing: 20.0, // Spacing between rows
                childAspectRatio: 1.0, // Aspect ratio of each item
              ),
              itemBuilder: (context, index) {
                var tractor = tractors[index].data() as Map<String, dynamic>;
                var docSnapshot = snapshot.data!.docs[index];
                String docId =docSnapshot.id;
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => CarDetailsPage(
                                      SellPrice:
                                          tractor['sellPrice']?.toString() ??
                                              '',
                                      description: tractor['description'] ?? '',
                                      brand: tractor['brand'] ?? '',
                                      model: tractor['model'] ?? '',
                                      RegYear:
                                          tractor['registrationYear'] ?? '',
                                      Pincode:
                                          tractor['pincode']?.toString() ?? '',
                                      HorsePower:
                                          tractor['horsePower']?.toString() ??
                                              '',
                                      Hours: tractor['hours'] ?? '',
                                      RegNum:
                                          tractor['registrationNumber'] ?? '',
                                      InsStatus:
                                          tractor['insuranceStatus'] ?? '',
                                      RearTire: tractor['rearTyre'] ?? '',
                                      Address: tractor['state'] ?? '',
                                      Break: tractor['break'] ?? '',
                                      PTO: tractor['Pto'] ?? '',
                                      CC: tractor['CC'] ?? '',
                                      Cooling: tractor['Cooling'] ?? '',
                                      LiftingCapacity:
                                          tractor['Lifting Capacity'] ?? '',
                                      SteeringType:
                                          tractor['Steering Type'] ?? '',
                                      ClutchType: tractor['Clutch Type'] ?? '',
                                      OilCap:
                                          tractor['Engine Oil Capacity'] ?? '',
                                      RunningKM: tractor['Running KM'] ?? '',
                                      Fuel: tractor['Fuel'] ?? '',
                                      tractorId: tractor['tractorId'],
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
                                    )));
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
                                'assets/images/banner1.jpg',
                                height: 150,
                                width: MediaQuery.of(context).size.width * 0.8,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 12, right: 5, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tractor['brandName'] ?? 'Mahindra Go',
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
                                                  BorderRadius.circular(6)),
                                          child: const Center(
                                            child: Text(
                                              "2022",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(
                                          height: size.height * 0.03,
                                          width: size.width * 0.22,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: const Center(
                                            child: Text(
                                              "450000 kms",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(
                                          height: size.height * 0.03,
                                          width: size.width * 0.11,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: const Center(
                                            child: Text(
                                              "Petrol",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(
                                          height: size.height * 0.03,
                                          width: size.width * 0.14,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: const Center(
                                            child: Text(
                                              "566 HP",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )),
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
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Text(
                                      //   'Insurance: ${vehicle['insuranceSecurity'] ?? ''}',
                                      //   style: const TextStyle(fontSize: 16.0),
                                      // ),
                                      Text(
                                        '₹${tractor['sellPrice'] ?? ''}',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              (context),
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ContactSellerScreen(
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
                                                      ),)); // Handle button press
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue[300],
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: const Text('Contact Seller'),
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
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllItems(),
                  ),
                );
              },
              child: Text(
                'View All',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue[200],
                    decorationColor: Colors.blue[200]),
              ),
            ),
          ),
        ],
      );
    },
  );
}
