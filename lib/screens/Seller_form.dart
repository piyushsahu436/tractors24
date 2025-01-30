import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';

class SellerformScreen extends StatelessWidget {
 SellerformScreen({super.key});
  final TextEditingController _brandsellerformController = TextEditingController();
  final TextEditingController _modelNumbersellerformController = TextEditingController();
  final TextEditingController _registrationyearsellerformController = TextEditingController();
  final TextEditingController _horsepowersellerformController = TextEditingController();
 final TextEditingController _hourssellerformController = TextEditingController();
 final TextEditingController _registratiosellerformController = TextEditingController();
 final TextEditingController _insurancesellerformController = TextEditingController();
 final TextEditingController _reartyresellerformController = TextEditingController();
 final TextEditingController _pincodesellerformController = TextEditingController();
 final TextEditingController _addresssellerformController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Seller Form',
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
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _pincodesellerformController ,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/placeholder.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Pincode',
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
                    controller:  _modelNumbersellerformController,
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
                    controller:  _modelNumbersellerformController,
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
                    controller: _registrationyearsellerformController,
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
                    controller: _horsepowersellerformController,
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
                    controller: _hourssellerformController,
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
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller:_registratiosellerformController,
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
                    controller:_insurancesellerformController,
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
                    controller: _reartyresellerformController,
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
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller:  _addresssellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/placeholder.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Address',
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
                        'Next',
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
