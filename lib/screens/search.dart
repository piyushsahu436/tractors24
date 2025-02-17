import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/policies_screen.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/vector7.png'),
                  fit: BoxFit.fill,
                )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: headerTemp(text: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 20.0),
                child: Text(
                  'Search Results :',
                  style: GoogleFonts.anybody(
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
              GridViewBuilderWidget(itemCount: 4),
            ],
          ),
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Brand Name',
                        hintStyle: GoogleFonts.anybody(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(124, 139, 160, 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search)),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Location',
                        hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromRGBO(124, 139, 160, 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.location_pin)),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
