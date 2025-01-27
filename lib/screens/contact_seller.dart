import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactSellerScreen extends StatelessWidget {
  const ContactSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(

          'Contact Seller',
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
                   SizedBox(height: size.height*0.01),
                  Row(
                    children:  [
                      Icon(Icons.location_on_outlined, ),
                      SizedBox(height: size.height*0.01),
                      Text('Indore, Madhya Pradesh', style: GoogleFonts.anybody(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),),
                    ],
                  ),
                  SizedBox(height: size.height*0.01),
                   Text(
                    '₹ 7,30,000',
                    style: GoogleFonts.anybody (
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: size.height*0.01),

                  // Form fields
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline ),
                      hintText: 'Full Name',
                      hintStyle: GoogleFonts.anybody(

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.01),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone ),
                      hintText: 'Phone Number',
                      hintStyle: GoogleFonts.anybody(

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: size.height*0.01),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_pin ),
                      hintText: 'PinCode',
                      hintStyle: GoogleFonts.anybody(
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: size.height*0.01),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Message (Optional)',
                      hintStyle: GoogleFonts.anybody(
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: size.height*0.01),

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
                        'Send Inquiry',
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