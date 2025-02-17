import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/data/ContaboImageHandling/Contabo_Image.dart';
import 'package:tractors24/screens/Seller_form2.dart';

class SellerformScreen extends StatefulWidget {
  SellerformScreen({super.key});

  @override
  State<SellerformScreen> createState() => _SellerformScreenState();
}

class _SellerformScreenState extends State<SellerformScreen> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController _modelNumbersellerformController =
      TextEditingController();
  final TextEditingController _registrationyearsellerformController =
      TextEditingController();
  final TextEditingController _horsepowersellerformController =
      TextEditingController();
  final TextEditingController _hourssellerformController =
      TextEditingController();
  final TextEditingController _registratiosellerformController =
      TextEditingController();
  final TextEditingController _insurancesellerformController =
      TextEditingController();
  final TextEditingController _reartyresellerformController =
      TextEditingController();
  final TextEditingController _pincodesellerformController =
      TextEditingController();
  final TextEditingController _addresssellerformController =
      TextEditingController();
  final TextEditingController _amountCont = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<String> uploadedUrls = [];
  List<File> selectedImages = [];
  bool _isUploading = false;

  File? _imageFile;

  final minio = Minio(
    endPoint: 'sin1.contabostorage.com',
    accessKey: '1eb0cbdee363c529fcbde7bf72e08ab3',
    secretKey: '650b25c6c6612a691a65654dc4ca77b1',
    useSSL: true,
  );

  Future<void> _pickImages(ImageSource source) async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles == null || pickedFiles.isEmpty) return;

    if (pickedFiles != null) {
      setState(() {
        selectedImages = pickedFiles.map((img) => File(img.path)).toList();
      });
    }

    if (pickedFiles.length > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can upload up to 5 images only!')),
      );
      return;
    }

    setState(() {
      selectedImages = pickedFiles.map((file) => File(file.path)).toList();
    });

    // for (var file in pickedFiles) {
    //   String? uploadedUrl = await _uploadToContabo(File(file.path));
    //   if (uploadedUrl != null) {
    //     uploadedUrls.add(uploadedUrl);
    //   }
    // }
    //
    // setState(() {
    //   _isUploading = false;
    // });
    //
    // // Print uploaded URLs or error message
    // if (uploadedUrls.isNotEmpty) {
    //   print("Uploaded Images: $uploadedUrls");
    // } else {
    //   print("Not uploaded");
    // }
  }
  // Future<String?> _uploadToContabo(File file) async {
  //   try {
  //     String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
  //
  //     await minio.fPutObject(
  //       'tractor24',
  //       fileName,
  //       file.path,
  //     );
  //
  //     return 'https://sin1.contabostorage.com/d1fa3867924f4c149226431ef8cbe8ee:tractor24/$fileName';
  //   } catch (e) {
  //     print("Upload Error: $e");
  //     return null;
  //   }
  // }

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
                  _pickImages(ImageSource.gallery);
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
                  _pickImages(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ADD POST',
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
                    child: _isUploading
                        ? Center(child: CircularProgressIndicator())
                        : PageView.builder(
                            itemCount: selectedImages.isNotEmpty
                                ? selectedImages.length
                                : uploadedUrls.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: selectedImages.isNotEmpty  // Check if local images exist
                                        ? FileImage(selectedImages[index]) as ImageProvider
                                        : (uploadedUrls.isNotEmpty // Check if uploaded URLs exist
                                        ? NetworkImage(uploadedUrls[index]) as ImageProvider
                                        : const AssetImage('assets/images/Rectangle 23807.png')
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  TextField(
                    controller: _pincodesellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: brandController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _modelNumbersellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _amountCont,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/power.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Price',
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
                    controller: _registrationyearsellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _horsepowersellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _hourssellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _registratiosellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _insurancesellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _reartyresellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                    controller: _addresssellerformController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellerFormScreen2(
                                      pincode: _pincodesellerformController,
                                      brand: brandController,
                                      model: _modelNumbersellerformController,
                                      horsePower:
                                          _horsepowersellerformController,
                                      RegNum: _registratiosellerformController,
                                      RegistrationYear:
                                          _registrationyearsellerformController,
                                      Hours: _hourssellerformController,
                                      RearTyre: _reartyresellerformController,
                                      InStatus: _insurancesellerformController,
                                      Address: _addresssellerformController,
                                      amount: _amountCont,
                                      uploadedUrls: uploadedUrls,
                                      selectedImages: selectedImages,
                                    )));
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
