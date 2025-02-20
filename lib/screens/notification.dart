import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/NewsDetails.dart';
import 'package:tractors24/screens/contact_seller.dart';
import 'package:tractors24/screens/policies_screen.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

final CollectionReference tractorsCollection =
    FirebaseFirestore.instance.collection('news');

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2472),
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('News'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 20),
              child: Text(
                '| New Listed',
                style: GoogleFonts.roboto(
                    color: const Color(0xFF414141),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
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
                    var tractor =
                        tractors[index].data() as Map<String, dynamic>;
                    List<String> imageUrls =
                        (tractor['images'] as List<dynamic>?)
                                ?.map((e) => e.toString())
                                .toList() ??
                            [];
                    var docSnapshot = snapshot.data!.docs[index];
                    String docId = docSnapshot.id;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => NewsDetails(
                                        image: tractor['image'],
                                        title: tractor['title'],
                                        content: tractor['content'])));
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
                                  child: Image.network(
                                    tractor['image'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tractor['title'] ?? 'Mahindra Go',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
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

                                      Text(
                                        '${tractor['content'] ?? ''}',
                                        maxLines: 3,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black),
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
          ],
        ),
      ),
    );
  }
}
