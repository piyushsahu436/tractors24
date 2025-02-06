import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  int selectedRating = 0;
  final TextEditingController _namereview = TextEditingController();
  final TextEditingController _numberreview = TextEditingController();
  final TextEditingController _feedbackreview = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Container(
            color: const Color(0xFF0A2472),
            child: Padding(
              padding:  EdgeInsets.only(top: size.height*0.15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                      color: Colors.black,
                        thickness: 3,
                        endIndent: 150,
                        indent: 150,
                      ),
                      Center(
                        child: Text(
                          'Share your experience',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Name TextField
                      Form_field(
                          hintText: 'Name',
                          controller: _namereview,
                          prefixtext: ''),
                      const SizedBox(height: 12),
                      Form_field(
                          hintText: 'Mobile Number',
                          controller: _numberreview,
                          prefixtext: ""),
                      const SizedBox(height: 20),
                      Text(
                        'How do you feel about our service?',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: List.generate(
                          5,
                              (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRating = index + 1; // Update rating
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                index < selectedRating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 32,
                                color: index < selectedRating
                                    ? const Color(0xFF0A2472)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        'Additional feedback',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1), // Soft shadow
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(2, 4), // Slight bottom shadow
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            hintText: 'Enter your feedback here...',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color.fromRGBO(124, 139, 160, 1.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          // Profile Picture Upload
                          Column(
                            children: [
                              Text(
                                'Profile Picture Upload',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              OutlinedButton.icon(
                                onPressed: () {
                                  // Image picker logic
                                },
                                icon: const Icon(
                                  Icons.upload,
                                  color: Color(0xFF0A2472),
                                ),
                                label: Text(
                                  'Upload',
                                  style:
                                  GoogleFonts.poppins(color: const Color(0xFF0A2472)),
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(150, 50),
                                  side: BorderSide(color: const Color(0xFF0A2472)!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 20),
                          // Media Upload
                          Column(
                            children: [
                              Text(
                                'Media Upload',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              OutlinedButton.icon(
                                onPressed: () {
                                  // Media picker logic
                                },
                                icon: const Icon(
                                  Icons.upload,
                                  color: Color(0xFF0A2472),
                                ),
                                label: Text(
                                  'Upload',
                                  style:
                                  GoogleFonts.poppins(color: const Color(0xFF0A2472)),
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(150, 50),
                                  side: BorderSide(color: const Color(0xFF0A2472)!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A2472),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
            Padding(
              padding:  EdgeInsets.only(left: 8.0,top: size.height*0.05),
              child: Row( mainAxisAlignment: MainAxisAlignment.start, // Aligns items from the start
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left:8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Testimonials',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width:20,),
                ],
              ),
            ),
        ]),
      ),
    );
  }
}