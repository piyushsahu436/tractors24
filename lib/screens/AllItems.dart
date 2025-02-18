import 'package:flutter/material.dart';
import 'package:tractors24/screens/contact_seller.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllItems extends StatefulWidget {
  const AllItems({super.key});

  @override
  State<AllItems> createState() => _AllItemsState();
}

final CollectionReference tractorsCollection =
    FirebaseFirestore.instance.collection('tractors');

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tractorsCollection.snapshots(),
        // builder: (context, snapshot) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return const Center(child: CircularProgressIndicator());
        //   }
        //
        //   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        //     return const Center(
        //       child: Text('No vehicles available.',
        //           style: TextStyle(fontSize: 18, color: Colors.grey)),
        //     );
        //   }
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
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var tractor = tractors[index].data() as Map<String, dynamic>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => CarDetailsPage(
                                    SellPrice:
                                        tractor['sellPrice']?.toString() ?? '',
                                    brand: tractor['brand'] ?? '',
                                    model: tractor['model'] ?? '',
                                    RegYear: tractor['registrationYear'] ?? '',
                                    Pincode:
                                        tractor['pincode']?.toString() ?? '',
                                    HorsePower:
                                        tractor['horsePower']?.toString() ?? '',
                                    Hours: tractor['hours'] ?? '',
                                    RegNum: tractor['registrationNumber'] ?? '',
                                    InsStatus: tractor['insuranceStatus'] ?? '',
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
                                    tractorId: tractor['tractorId'] ?? '',
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
                                    pincode: tractor['pincode'] ?? '',
                                    clutch: tractor['clutch']?? '',
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
                              width: MediaQuery.of(context).size.width * 1,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                      '₹${tractor['sellPrice'] ?? ''}',
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
          );
        },
      ),
    );
  }
}
