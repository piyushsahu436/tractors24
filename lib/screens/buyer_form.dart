import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';

class BuyerformScreen extends StatelessWidget {
 BuyerformScreen({super.key});
  final TextEditingController _brandbuyerformController = TextEditingController();
  final TextEditingController _modelNumberbuyerformController = TextEditingController();
  final TextEditingController _registrationyearbuyerformController = TextEditingController();
  final TextEditingController _horsepowerbuyerformController = TextEditingController();
 final TextEditingController _hoursbuyerformController = TextEditingController();
 final TextEditingController _registratiobuyerformController = TextEditingController();
 final TextEditingController _insurancebuyerformController = TextEditingController();
 final TextEditingController _reartyrebuyerformController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Buyers Form',
          style: GoogleFonts.anybody(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Rectangle 23807.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mahindra Arjun 555 DI',
                    style: GoogleFonts.anybody(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Indore, Madhya Pradesh',
                        style: GoogleFonts.anybody(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '₹ 7,30,000',
                    style: GoogleFonts.anybody(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),

                  TextField(
                    controller: _brandbuyerformController ,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/brand-image.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Brand',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller:  _modelNumberbuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/tractor.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Model',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller: _registrationyearbuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/calendar.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Registration Year',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),

                  TextField(
                    controller: _horsepowerbuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/power.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Horse Power',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),

                  TextField(
                    controller: _hoursbuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/time-left.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Hours',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _registratiobuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/registration.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Registration Number',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller:_insurancebuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/clipboard.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Insurance Status',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller: _reartyrebuyerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/tire.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Rear Tyre',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),

                  // Send Inquiry Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement send inquiry logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003B8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Post',
                        style: GoogleFonts.anybody(
                          color: Colors.white,
                          fontSize: 16,
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
  }
}
