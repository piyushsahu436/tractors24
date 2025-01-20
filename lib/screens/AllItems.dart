import 'package:flutter/material.dart';
import 'package:tractors24/screens/ContactInfo.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllItems extends StatefulWidget {
  const AllItems({super.key});

  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
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
                              'assets/images/banner1.jpg',
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
                                                const ContactSellerScreen())); // Handle button press
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
    );
  }
}
