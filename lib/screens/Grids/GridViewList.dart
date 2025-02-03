import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/contact_seller.dart';

class GridViewBuilderWidget extends StatelessWidget {
  const GridViewBuilderWidget({super.key, required this.itemCount});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 0.62, // Aspect ratio of each item
        ),
        itemCount: itemCount, // Number of items
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CarDetailsPage()));},
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
                            image: AssetImage("assets/images/temp1.jpg"),
                            fit: BoxFit.fill,
                          )),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF003B8F),
                                          borderRadius: BorderRadius.circular(20)),
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
                                      image:
                                          AssetImage("assets/images/favIcon.png"),
                                      height: 18,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            'Mahindra Go',
                            semanticsLabel: '',
                            style: GoogleFonts.anybody(
                              color: const Color(0xFF050B20),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: size.height * 0.007),

                          // Location and KM Info

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage("assets/images/locaIcon.png"),
                                      height: 12,
                                    ),
                                    SizedBox(width: size.width * 0.015),
                                    Text(
                                      "Indore",
                                      style: GoogleFonts.anybody(
                                        color: const Color(0xFF414141),
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage("assets/images/kmIcon.png"),
                                      height: 9,
                                    ),
                                    SizedBox(width: size.width * 0.015),
                                    Text(
                                      "40,000 KM",
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
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Text(
                            '₹7,30,000',
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
                )),
          );
        },
      ),
    );
  }
}