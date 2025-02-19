import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactSellerScreen extends StatefulWidget {
  const ContactSellerScreen({super.key, required this.docid});
  final String docid;

  @override
  State<ContactSellerScreen> createState() => _ContactSellerScreenState();
}

class _ContactSellerScreenState extends State<ContactSellerScreen> {
  final TextEditingController _namecontactsellerController =
      TextEditingController();
  final TextEditingController _mobileNumbercontactsellerController =
      TextEditingController();
  final TextEditingController _messagecontactsellerController =
      TextEditingController();
  final TextEditingController _pincodecontactsellerController =
      TextEditingController();

  Future<void> addEnquiry(BuildContext context) async {
    try {
      // Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Adding data to loan_enquiries collection
      await firestore.collection('inquiries').add({
        'Name': _namecontactsellerController.text.trim(),
        'ContactNo': _mobileNumbercontactsellerController.text.trim(),
        'Message': _messagecontactsellerController.text.trim(),
        'PinCode': _pincodecontactsellerController.text.trim(),
        'status': "pending",
        'timestamp': FieldValue.serverTimestamp(),
        'tractorid': widget.docid// Optional for sorting
      });

      // Clear input fields
      _namecontactsellerController.clear();
      _mobileNumbercontactsellerController.clear();
      _messagecontactsellerController.clear();
      _pincodecontactsellerController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inquiry added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add Inquiry: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Inquiry',
          style: GoogleFonts.roboto(
            fontSize: 29,
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
                    style: GoogleFonts.roboto(
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
                        style: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '₹ 7,30,000',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),

                  // Form fields
                  TextField(
                    controller: _namecontactsellerController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/user.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Full Name',
                      hintStyle: GoogleFonts.roboto(),
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
                    controller: _mobileNumbercontactsellerController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/phone-call.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Phone Number',
                      hintStyle: GoogleFonts.roboto(),
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
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller: _pincodecontactsellerController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/placeholder.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'PinCode',
                      hintStyle: GoogleFonts.roboto(),
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
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    controller: _messagecontactsellerController,
                    decoration: InputDecoration(
                      hintText: 'Message (Optional)',
                      hintStyle: GoogleFonts.roboto(),
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
                  SizedBox(height: size.height * 0.01),

                  // Send Inquiry Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:() => addEnquiry(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003B8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Send Inquiry',
                        style: GoogleFonts.roboto(
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
