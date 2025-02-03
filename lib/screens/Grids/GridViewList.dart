import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/contact_seller.dart';

class GridViewBuilderWidget extends StatelessWidget {
  GridViewBuilderWidget({super.key, required this.itemCount});
  final int itemCount;

  final CollectionReference tractorsCollection =
  FirebaseFirestore.instance.collection('tractors');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: tractorsCollection.snapshots(),
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
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.62,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              var tractor = tractors[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarDetailsPage()));
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
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/temp1.jpg"), // Replace with tractor image URL
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Column(
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
                                            BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(" Great Price ",
                                              style: GoogleFonts.anybody(
                                                color: Colors.white,
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                      const Image(
                                        image: AssetImage(
                                            "assets/images/favIcon.png"),
                                        height: 18,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
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
                              style: GoogleFonts.anybody(
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
                                        tractor['district'] ?? 'Unknown',
                                        style: GoogleFonts.anybody(
                                          color: const Color(0xFF414141),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                        '${tractor['hours']} hr' ?? 'Unknown',
                                        style: GoogleFonts.anybody(
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
                              '₹${tractor['sellPrice']}',
                              style: GoogleFonts.anybody(
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
                                      builder: (context) =>
                                          ContactSellerScreen(),
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
                                  style: GoogleFonts.anybody(
                                    fontSize: 12,
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
