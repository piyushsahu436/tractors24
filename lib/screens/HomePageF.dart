import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/AllBrands.dart';
import 'package:tractors24/screens/Grids/Brand_Grids.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/Grids/StatesGrids.dart';
import 'package:tractors24/screens/faq_list.dart';

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Stack(children: [
                  CarouselSlider(
                      items: [
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/first_carou.png'),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/car2_page.png'),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/car3_page.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                      options: CarouselOptions(
                          height: size.height * 0.37,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3))),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 16,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 08.0, left: 0),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: const Image(
                                    image:
                                        AssetImage("assets/images/grp29.png")),
                              ),
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
                            const Padding(
                              padding: EdgeInsets.only(left: 5, right: 3),
                              child: Image(
                                image: AssetImage("assets/images/location.png"),
                                height: 18,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Indore",
                                style: GoogleFonts.anybody(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                    ],
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.34),
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.03,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22))),
                  ),
                ),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 0, bottom: 8),
                    child: Text(
                      '|  Recently Added Tractor',
                      style: GoogleFonts.anybody(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                   GridViewBuilderWidget(
                    itemCount: 4,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/seeImg.png"),
                        height: 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      '|  Popular Tractor',
                      style: GoogleFonts.anybody(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                   GridViewBuilderWidget(
                    itemCount: 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/seeImg.png"),
                        height: 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0),
                    child: Container(
                      height: 132,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/BgImg.png"))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2,
                              child: Text(
                                "Are You Looking For a Tractor ?",
                                style: GoogleFonts.anybody(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const Expanded(
                              child: Image(
                                image: AssetImage("assets/images/clkButton.png"),
                                height: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      '|  Recommend Tractor',
                      style: GoogleFonts.anybody(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                   GridViewBuilderWidget(
                    itemCount: 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/seeImg.png"),
                        height: 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      '|  Certified Tractor',
                      style: GoogleFonts.anybody(
                          color: const Color(0xFF414141),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                   GridViewBuilderWidget(
                    itemCount: 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/seeImg.png"),
                        height: 26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 0),
                    child: Container(
                      height: 132,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/BgImg.png"))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2,
                              child: Text(
                                "Are You Looking For a Tractor ?",
                                style: GoogleFonts.anybody(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const Expanded(
                              child: Image(
                                image: AssetImage("assets/images/clkButton.png"),
                                height: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 20, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '|  Brand',
                          style: GoogleFonts.anybody(
                              color: const Color(0xFF414141),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BrandsPage()));
                            },
                            child: Text(
                              'See More',
                              style: GoogleFonts.anybody(
                                  color: const Color(0xFF003B8F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ))
                      ],
                    ),
                  ),
                  BrandGrids(itemCount: 8,),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 20, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '|  Search Tractor By \n state',
                          style: GoogleFonts.anybody(
                              color: const Color(0xFF414141),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'See More',
                              style: GoogleFonts.anybody(
                                  color: const Color(0xFF003B8F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  StateGrids(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 0),
                    child: Container(
                      height: 132,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/BgImg.png"))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Image(
                                image: AssetImage("assets/images/clkButton.png"),
                                height: 35,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(flex: 2,
                              child: Text(
                                "Do You Want to Sell a Tractor ?",
                                style: GoogleFonts.anybody(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // FAQScreen(),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "FAQ's",
                      style: GoogleFonts.anybody(
                          color: const Color(0xFF414141),
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, right: 15, left: 15),
                    child: Text(
                      "Question Commonly Asked by Buyer's and Seller",
                      style: GoogleFonts.anybody(
                          color: const Color(0xFF414141),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const FAQList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
