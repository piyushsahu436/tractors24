import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tractors24/auth/login_page.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _nameprofileController = TextEditingController();
  final TextEditingController _mobileprofileController = TextEditingController();
  final TextEditingController _emailprofileController = TextEditingController();
  final TextEditingController _pinCodeprofileController = TextEditingController();

  // Image picker instance
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
                leading: Icon(Icons.photo_library),
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

  @override
  void dispose() {
    _nameprofileController.dispose();
    _mobileprofileController.dispose();
    _emailprofileController.dispose();
    _pinCodeprofileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
          children: [
            // Top curved container
            Container(
              height: 120,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
                image: DecorationImage(image: AssetImage("assets/images/profilebackground.png"),
                    fit: BoxFit.cover),

              ),

              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Profile image
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.person,
                          size: 50, color: Colors.grey)
                          : null,
                    ),
                    // Edit icon
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 18, color: Colors.black,),
                          onPressed: _showImageSourceDialog,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Personal Info text
            Text(
              'Personal Info',
              style: GoogleFonts.anybody(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0A2472),
              ),
            ),

            const SizedBox(height: 10),
            Text('I`m a',style: TextStyle( fontSize: 16.0,fontWeight: FontWeight.w600),),

            // I'm a Customer button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A2472),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Customer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Form_field(hintText: 'Name', controller: _nameprofileController, prefixtext: ''),
                  const SizedBox(height: 8),
                  Form_field(hintText: 'Mobile Number', controller: _mobileprofileController, prefixtext: ''),
                  const SizedBox(height: 8),
                  Form_field(hintText: 'Email ID', controller: _emailprofileController, prefixtext: ''),
                  const SizedBox(height: 8),
                  Form_field(hintText: 'Pin Code', controller: _pinCodeprofileController, prefixtext: ''),
                  const SizedBox(height: 15),

                  // Change Password button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color:Color(0xFF0A2472)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.lock_outline,color: Color(0xFF0A2472),),
                      label:  Text('Change Password',style: GoogleFonts.poppins(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // KYC Documents link
                  _buildClickableText('Click Here', 'To Upload KYC Documents'),

                  const SizedBox(height: 10),

                  // Deactivate Account link
                  _buildClickableText('Click Here', 'Deactivate Your Account'),

                  const SizedBox(height: 20),

                  // Save Details button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle save details
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A2472),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Save Details',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  // Helper method to build clickable text
  Widget _buildClickableText(String clickText, String description) {
    return Row(
      children: [
      Text(
      '$clickText ',
      style: GoogleFonts.anybody(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(0, 59, 143, 1),
        decoration: TextDecoration.underline,
      ),
    ),
    Text(description, style: GoogleFonts.anybody(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    ),),
    ],
    );
    }
}