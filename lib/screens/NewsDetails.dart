import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/contact_seller.dart';
import "package:tractors24/screens/loanEnquire.dart";
import 'package:tractors24/screens/policies_screen.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({
    super.key,
    required this.image,
    required this.title,
    required this.content,
  });
  final String image;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003B8F),
          foregroundColor: Colors.white,
          title: const Text('News'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Text(
                    title,
                    softWrap: true,
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                ),
              ),
              // Image section
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child:  ClipRRect(
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Text(
                  content,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.roboto(fontSize: 15, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
