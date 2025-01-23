import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageF extends StatefulWidget {
  const HomePageF({super.key});

  @override
  State<HomePageF> createState() => _HomePageFState();
}

class _HomePageFState extends State<HomePageF> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(children: [
              CarouselSlider(
                  items: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/car1_page.png'),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/car2_page.png'),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/car3_page.png'),
                              fit: BoxFit.cover)),
                    ),
                  ],
                  options: CarouselOptions(
                      height: size.height * 0.36,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3))),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Image(image: AssetImage("assets/images/grp29.png")),
                    ),
                    SizedBox(
                      height: 45,
                      width: size.width * 0.6,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white, filled: true,
                          hintText: 'Search Tractor',
                          hintStyle: GoogleFonts.anybody(
                            color: Colors.grey[400],
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ), // Adjust padding as needed
                        ),
                      ),
                    ),
                    const Image(image: AssetImage("assets/images/location.png")),
                    Text("Indore",style:GoogleFonts.anybody(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ), )
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
