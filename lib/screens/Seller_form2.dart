import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';

class SellerformScreen2 extends StatelessWidget {
  SellerformScreen2({super.key});
  final TextEditingController _sfbreak = TextEditingController();
  final TextEditingController _sfTransmission = TextEditingController();
  final TextEditingController _spPto = TextEditingController();
  final TextEditingController _sfCc = TextEditingController();
  final TextEditingController _sfCooling = TextEditingController();
  final TextEditingController _sfLifting = TextEditingController();
  final TextEditingController sfSteering = TextEditingController();
  final TextEditingController _sfClutch = TextEditingController();
  final TextEditingController _sfOil = TextEditingController();
  final TextEditingController _sffuel = TextEditingController();
  final TextEditingController _sfKm = TextEditingController();

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _sfbreak ,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/break.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Break',
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
                    controller:  _sfTransmission,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/transmission.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Transmission',
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
                    controller:  _sfTransmission,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/energy.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'PTO',
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
                    controller: _spPto,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/cc.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'CC',
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
                    controller: _sfCc,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/fan.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Cooling',
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
                    controller: _sfCooling,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/settings.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Lifting Capacity',
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
                    controller: _sfLifting,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/steering.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Steering Type',
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
                    controller:sfSteering,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/clutch.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Clutch Type',
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
                    controller: _sfClutch,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/oil.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Engine oil capacity',
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
                    controller:  _sfKm,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/km.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Running KM',
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
                    controller:  _sffuel,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/gas.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Fuel',
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
