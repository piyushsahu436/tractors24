import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/forget_pass.dart';

class PersonalInfoEditScreen extends StatefulWidget {
  const PersonalInfoEditScreen({super.key});

  @override
  State<PersonalInfoEditScreen> createState() => _PersonalInfoEditScreenState();
}

class _PersonalInfoEditScreenState extends State<PersonalInfoEditScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameprofileController = TextEditingController();
  final TextEditingController _mobileprofileController =
      TextEditingController();
  final TextEditingController _emailprofileController = TextEditingController();
  final TextEditingController _pinCodeprofileController =
      TextEditingController();
  String profileImageUrl = "";
  File? selectedImages;
  bool isLoading = true;

  final minio = Minio(
    endPoint: 'sin1.contabostorage.com',
    accessKey: '1eb0cbdee363c529fcbde7bf72e08ab3',
    secretKey: '650b25c6c6612a691a65654dc4ca77b1',
    useSSL: true,
  );

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      selectedImages = File(pickedFile.path);
    });
  }


  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          _nameprofileController.text = userDoc['name'];
          _mobileprofileController.text = userDoc['phone'];
          _emailprofileController.text = userDoc['email'];
          _pinCodeprofileController.text = userDoc['pincode'];
          profileImageUrl = userDoc['profileImage'] ?? "";
          isLoading = false;
        });
      }
    }
  }

  Future<void> updateUserData() async {
    User? user = _auth.currentUser;
    String? profileImageUrl = await  _uploadToContabo(selectedImages!);
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': _nameprofileController.text,
        'mobile': _mobileprofileController.text,
        'email': _emailprofileController.text,
        'pincode': _pinCodeprofileController.text,
        'profileImage': profileImageUrl,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile Updated!')));
    }
  }
  Future<String?> _uploadToContabo(File file) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      await minio.fPutObject(
        'tractor24',
        fileName,
        file.path,
      );

      return 'https://sin1.contabostorage.com/d1fa3867924f4c149226431ef8cbe8ee:tractor24/$fileName';
    } catch (e) {
      print("Upload Error: $e");
      return null;
    }
  }

  // Image picker instance
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  // Function to pick image from gallery or camera
  // Show image source selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source',
              style: GoogleFonts.roboto(
                fontSize: 20,
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  'Gallery',
                  style: GoogleFonts.roboto(),
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
                  style: GoogleFonts.roboto(),
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
            Stack(children: [
              Image(
                image: const AssetImage("assets/images/gradient.png"),
                // height: size.height * 1,
                width: size.width * 1,
              ),

              Padding(
                padding: EdgeInsets.only(top: size.height * 0.15),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22)),
                    // image: DecorationImage(image: AssetImage("assets/images/profilebackground.png"),fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      // Personal Info text
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.1),
                        child: Text(
                          'Personal Info',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0A2472),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'I`m a',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),

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
                            Form_field(
                              hintText: 'Name',
                              controller: _nameprofileController,
                              prefixtext: '',
                              validator: (String? value) {},
                            ),
                            const SizedBox(height: 8),
                            Form_field(
                              hintText: 'Mobile Number',
                              controller: _mobileprofileController,
                              prefixtext: '',
                              validator: (String? value) {},
                            ),
                            const SizedBox(height: 8),
                            Form_field(
                              hintText: 'Email ID',
                              controller: _emailprofileController,
                              prefixtext: '',
                              validator: (String? value) {},
                            ),
                            const SizedBox(height: 8),
                            Form_field(
                              hintText: 'Pin Code',
                              controller: _pinCodeprofileController,
                              prefixtext: '',
                              validator: (String? value) {},
                            ),
                            const SizedBox(height: 15),

                            // Change Password button
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF0A2472)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPassword()));
                                },
                                icon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF0A2472),
                                ),
                                label: Text(
                                  'Change Password',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // KYC Documents link
                            _buildClickableText(
                                'Click Here', 'To Upload KYC Documents'),

                            const SizedBox(height: 10),

                            // Deactivate Account link
                            _buildClickableText(
                                'Click Here', 'Deactivate Your Account'),

                            const SizedBox(height: 20),

                            // Save Details button
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: updateUserData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0A2472),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
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
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                left: size.width * 0.05,
                right: size.width * 0.05,
                child:
                    Stack(alignment: AlignmentDirectional.topCenter, children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                    top: 1.5,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          selectedImages != null ? FileImage(selectedImages!) : null,
                      child: selectedImages == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.grey)
                          : null,
                      // backgroundImage: profileImageUrl.isNotEmpty
                      //     ? NetworkImage(profileImageUrl)
                      //     : const AssetImage('assets/default_avatar.png')
                      // as ImageProvider,
                      // child: _imageFile == null
                      //     ? const Icon(Icons.person,
                      //     size: 50, color: Colors.grey)
                      //     : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: size.width * 0.15,
                    bottom: 0,
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
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: _showImageSourceDialog,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              // Edit icon
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: CircleAvatar(
              //     backgroundColor: Colors.white,
              //     radius: 18,
              //     child: IconButton(
              //       icon: const Icon(Icons.edit, size: 18, color: Colors.black,),
              //       onPressed: _showImageSourceDialog,
              //     ),
              //   ),
              // ),
            ]),
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
          style: GoogleFonts.roboto(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(0, 59, 143, 1),
            decoration: TextDecoration.underline,
          ),
        ),
        Text(
          description,
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class NonEditFormField extends StatelessWidget {
  NonEditFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.prefixtext});
  final String hintText;
  final TextEditingController controller;
  final String prefixtext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
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
        child: TextFormField(
          enabled: false,

          controller: controller,
          // keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: const Color.fromRGBO(124, 139, 160, 1.0)),
            prefixText: prefixtext,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null; // No error
          },
        ),
      ),
    );
  }
}
