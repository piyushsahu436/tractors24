import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/policies_screen.dart';

class SearchTractor extends StatefulWidget {
  const SearchTractor({super.key});

  @override
  State<SearchTractor> createState() => _SearchTractorState();
}

class _SearchTractorState extends State<SearchTractor> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _namesearch = TextEditingController();
    final TextEditingController _locationsearch = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
        children: [
        // First container with Stack
        Container(
        height: 200, // Adjust height as needed
        child: Stack(
        children: [
        // Background Image Container
        Container(
        width: double.infinity,
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/vector5.png'), // Add your image path
    fit: BoxFit.fill,
    ),
    ),
    ),


    Positioned(
    top:90,
    left: 16,
    right: 16,
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), // Soft shadow
        blurRadius: 10,
        spreadRadius: 2,
        offset: const Offset(2, 4), // Slight bottom shadow
      ),
    ],
    ),
    child: const TextField(
    decoration: InputDecoration(
    hintText: 'Mahindra Arjun 555 DI',
    prefixIcon: Icon(Icons.search),
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(16),
    ),
    ),
    ),
    ),

    // Location TextField
    Positioned(
    top: 147, // Adjust these values
    left: 16,
    right: 16,
    child: Container(
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), // Soft shadow
        blurRadius: 10,
        spreadRadius: 2,
        offset: const Offset(2, 4), // Slight bottom shadow
      ),
    ],
    ),
    child: const TextField(
    decoration: InputDecoration(
    hintText: 'Indore, Madhaya Pradesh',
    prefixIcon: Icon(Icons.location_on),
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(16),
    ),
    ),
    ),
    ),
          // Second plain container

    ],
    ),
    ),

          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Search Details:", style: GoogleFonts.anybody(fontSize: 16,fontWeight: FontWeight.w500),)
                ],
              ),
            ),
          ),
    ],
    ));
  }
}
