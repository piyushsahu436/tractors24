import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
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
  final ImagePicker _picker = ImagePicker();
  late File selectedImage;
  bool _isUploading = false;
  File? _imageFile;



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
      selectedImage = File(pickedFile.path);
    });
  }

// Show image source selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Image Source',
            style: GoogleFonts.roboto(fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Gallery', style: GoogleFonts.roboto()),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Camera', style: GoogleFonts.roboto()),
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

  Future<void> addTestimonial() async {
    try {
      // Get the current user's UID
      setState(() {
        _isUploading = true;
      });
      String? uploadedUrl = await uploadSingleFile(selectedImage);
      if (uploadedUrl != null) {
        print("✅ File uploaded: $uploadedUrl");
      } else {
        print("❌ Upload failed");
      }

      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw 'User not authenticated!';
      }

      // Generate a new document reference (random ID)
      DocumentReference docRef =
      FirebaseFirestore.instance.collection('testimonials').doc();
      final tractorData = {
      "name":_namereview.text.trim(),
      "mobile_number" : _numberreview.text.trim(),
      "feedback": _feedbackreview.text.trim(),
      "rating": selectedRating.toInt(),
      "image": uploadedUrl
      };

      await docRef.set(tractorData);
      setState(() {
        _isUploading = false;
      });
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

  Future<String?> uploadSingleFile(File file) async {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: const Color(0xFF0A2472),
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.15),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                        prefixtext: '',
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Form_field(
                        hintText: 'Mobile Number',
                        controller: _numberreview,
                        prefixtext: "",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
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
                              color:
                                  Colors.black.withOpacity(0.1), // Soft shadow
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset:
                                  const Offset(2, 4), // Slight bottom shadow
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _feedbackreview,
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            hintText: 'Enter your feedback here...',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color:
                                    const Color.fromRGBO(124, 139, 160, 1.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          // Profile Picture Upload

                          const SizedBox(width: 20),
                          // Media Upload
                          Column(mainAxisAlignment: MainAxisAlignment.center,
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
                                  _showImageSourceDialog();
                                },
                                icon: const Icon(
                                  Icons.upload,
                                  color: Color(0xFF0A2472),
                                ),
                                label: Text(
                                  'Upload',
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFF0A2472)),
                                ),
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(150, 50),
                                  side: BorderSide(
                                      color: const Color(0xFF0A2472)!),
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
                          onPressed: _isUploading ? null : addTestimonial,
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
            padding: EdgeInsets.only(left: 8.0, top: size.height * 0.05),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Aligns items from the start
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
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
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
