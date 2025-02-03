import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SellerFormScreen2 extends StatefulWidget {
  const SellerFormScreen2(
      {super.key,
      required this.pincode,
      required this.brand,
      required this.model,
      required this.RegistrationYear,
      required this.horsePower,
      required this.Hours,
      required this.RegNum,
      required this.InStatus,
      required this.RearTyre,
      required this.Address, required this.amount});
  final TextEditingController pincode;
  final TextEditingController brand;
  final TextEditingController model;
  final TextEditingController RegistrationYear;
  final TextEditingController horsePower;
  final TextEditingController Hours;
  final TextEditingController RegNum;
  final TextEditingController InStatus;
  final TextEditingController RearTyre;
  final TextEditingController Address;
  final TextEditingController amount;

  @override
  State<SellerFormScreen2> createState() => _SellerFormScreen2State();
}

  class _SellerFormScreen2State extends State<SellerFormScreen2> {
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

  final ImagePicker _picker = ImagePicker();

  File? _imageFile;

  // Function to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Show image source selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source',
              style: GoogleFonts.anybody(
                fontSize: 20,
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  'Gallery',
                  style: GoogleFonts.anybody(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'Camera',
                  style: GoogleFonts.anybody(),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addTractor() async {
    try {
      final tractorData = {
        "brand": widget.brand.text.trim(),
        "model": widget.model.text.trim(),
        "registrationNumber": widget.RegNum.text.trim(),
        "registrationYear": widget.RegistrationYear.text.trim(),
        "horsePower": widget.horsePower.text.trim(),
        "hours": widget.Hours.text.trim(),
        "category": "popular",
        // "state": stateController.text.trim(),
        "address": widget.Address.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
        "description": "",
        // "district": "Pune", // Example: Replace with dynamic input if needed
        "insuranceStatus": widget.InStatus.text.trim(), // Example: Replace with dynamic input if needed
        "listingDate": DateTime.now().toUtc().toIso8601String(),
        "pincode": widget.pincode.text.trim(), // Example: Replace with dynamic input if needed
        "rearTyre": widget.RearTyre.text.trim(), // Example: Replace with dynamic input if needed
        "sellPrice": widget.amount.text.trim(), // Example: Replace with dynamic input if needed
        // "showroomPrice": "1000000", // Example: Replace with dynamic input if needed
        "status": "pending",
        "break":_sfbreak.text.trim(),
        "Transmission":_sfTransmission.text.trim(),
        "Pto":_spPto.text.trim() ,
        "CC":_sfCc.text.trim()  ,
        "Cooling":_sfCooling.text.trim(),
        "Lifting Capacity":_sfLifting.text.trim(),
        "Steering Type":sfSteering.text.trim(),
        "Clutch Type":_sfClutch.text.trim(),
        "Engine Oil Capacity":_sfOil.text.trim() ,
        "Fuel":_sffuel.text.trim() ,
        "Running KM" : _sfKm.text.trim(),
        // "viewCount": 0,
      };

      await FirebaseFirestore.instance.collection('tractors').add(tractorData);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Tractor added successfully!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add tractor: $e'),
      ));
    }
  }


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
              height: 240,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Rectangle 23807.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  right: 30,
                  child: GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300, // Shadow color
                            spreadRadius: 3, // Spread of shadow
                            blurRadius: 20, // Blur effect
                            offset: const Offset(2, 12), // Shadow position
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: Image.asset(
                          "assets/icons/camera.png",
                          height: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _sfbreak,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                    controller: _sfTransmission,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                    controller: sfSteering,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                    controller: _sfOil,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                    controller: _sfKm,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                    controller: _sffuel,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
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
                      onPressed: addTractor,
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
