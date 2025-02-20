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

  String? selectedBrand;

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
  }

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
                  _pickImages(ImageSource.gallery);
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
        backgroundColor: Color(0xFF003B8F),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Add Post',
          style: GoogleFonts.roboto(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        ),
        
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
                                    image: selectedImages
                                            .isNotEmpty // Check if local images exist
                                        ? FileImage(selectedImages[index])
                                            as ImageProvider
                                        : (uploadedUrls
                                                .isNotEmpty // Check if uploaded URLs exist
                                            ? NetworkImage(uploadedUrls[index])
                                                as ImageProvider
                                            : const AssetImage(
                                                'assets/images/Rectangle 23807.png')),
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
                      hintStyle: GoogleFonts.roboto(
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
                  DropdownButtonFormField<String>(
                    value: selectedBrand,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBrand = newValue;
                      });
                    },
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
                      hintStyle: GoogleFonts.roboto(
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
                    items: [
                      "Eicher",
                      "Escorts",
                      "John Deere",
                      "M&M",
                      "New Holland",
                      "Power Trac",
                      "Preet",
                      "Sonalika",
                      "Swaraj",
                      "TAFE",
                      "Kubota",
                      "Solis",
                      "TMTL (Eicher)"
                    ].map<DropdownMenuItem<String>>((String brand) {
                      return DropdownMenuItem<String>(
                        value: brand,
                        child: Text(
                          brand,
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ),


                  SizedBox(height: size.height * 0.01),
                  DropdownButtonFormField<String>(
                    value: selectedBrand ?? null, // Ensure it is either a valid value or null
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedBrand = newValue;
                        });
                      }
                    },
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
                      hintStyle: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color.fromRGBO(124, 139, 160, 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    items: [
                      "A211N",
                      "Atom 26 4WD",
                      "B2441",
                      "DI - 55",
                      "DI 35",
                      "DI 35 MM",
                      "DI 35 Rx",
                      "DI 42",
                      "DI 42 RX",
                      "DI 47",
                      "DI 50",
                      "DI 60",
                      "DI 60 MM",
                      "DI 730",
                      "DI 734",
                      "DI 740",
                      "DI 745III POWER PLUS",
                      "DI 745III Rx POWER PLUS",
                      "DI 750 III",
                      "DI 750 III Rx",
                      "E-241",
                      "E-242",
                      "E-312",
                      "E-333",
                      "E-364",
                      "E-368",
                      "E-380",
                      "E-480",
                      "E-485",
                      "E-548",
                      "E-551",
                      "E-557",
                      "E-5660",
                      "EIC 5150",
                      "EIC 650",
                      "EIC557_4WD",
                      "EIC650_4WD",
                      "FARMTRAC 30 HERO",
                      "FARMTRAC 35",
                      "FARMTRAC 40",
                      "FARMTRAC 41",
                      "FARMTRAC 45",
                      "FARMTRAC 60",
                      "FARMTRAC 65",
                      "FARMTRAC 6060",
                      "FARMTRAC XP 37 CHAMPION",
                      "Fram trac_39",
                      "Fram trac_42",
                      "FRAMTRAC 44",
                      "FRAMTRAC CHAMPION",
                      "FT 50",
                      "FT 6045 LM",
                      "FT 6045 SM",
                      "FT 6050",
                      "FT 6055",
                      "FT 6055 Powermaxx",
                      "FT 6055 Powermaxx 4 WD",
                      "FT 60 Powermaxx",
                      "FT 60 Powermaxx 4 WD",
                      "FT-50 Powermaxx",
                      "ITL 20",
                      "ITL 26G",
                      "ITL 32RX",
                      "ITL 41 MM",
                      "ITL 50 MM",
                      "ITL MM 39",
                      "JD 5005",
                      "JD 5036",
                      "JD 5038",
                      "JD 5039",
                      "JD 5041 C",
                      "JD 5042",
                      "JD 5045 D",
                      "JD 5045D MFWD",
                      "JD 5050 4WD",
                      "JD 5050 D",
                      "JD 5050 E",
                      "JD 5055 4WD",
                      "JD 5055 D",
                      "JD 5055 E",
                      "JD 5060",
                      "JD 5103",
                      "JD 5104",
                      "JD 5104 4WD",
                      "JD 5105",
                      "JD 5204",
                      "JD 5205",
                      "JD 5210",
                      "JD 5305",
                      "JD 5310",
                      "JD 5310 4WD",
                      "JD 5405",
                      "JD 5405 4WD",
                      "MAHINDRA 215",
                      "MAHINDRA 225",
                      "MAHINDRA 255 DI",
                      "MAHINDRA 265 DI",
                      "MAHINDRA 275 DI",
                      "MAHINDRA 295 DI",
                      "MAHINDRA 365",
                      "MAHINDRA 395 DI",
                      "MAHINDRA 415",
                      "MAHINDRA 475 DI",
                      "MAHINDRA 555 DI",
                      "MAHINDRA 575 DI",
                      "MAHINDRA 585",
                      "MAHINDRA 595 DI",
                      "MAHINDRA 605 DI",
                      "MF 1035 DI R",
                      "MF 1035 DI TONNER",
                      "MF 1035 Mahashakti",
                      "MF 241 DI Mahashakti",
                      "MF 241 DI PD",
                      "MF 241 TONNER",
                      "MF 245 DI",
                      "MF 7250",
                      "MF 9000 PD",
                      "MU4501- 2WD - STD",
                      "MU4501- 4WD",
                      "MU5501",
                      "MU5501 -4WD",
                      "MU5502 - 2WD",
                      "MU5502 - 4WD",
                      "NH 3030",
                      "NH 3037",
                      "NH 3032",
                      "NH 3230",
                      "NH 3510",
                      "NH 3600",
                      "NH 3600-2",
                      "NH 3600-2 4WD",
                      "NH 3630",
                      "NH 4010",
                      "NH 4510",
                      "NH 4710",
                      "NH 5500",
                      "NH 5620",
                      "NH 6010",
                      "NH 7500",
                      "POWERTRAC 425",
                      "POWERTRAC 434",
                      "POWERTRAC 439",
                      "POWERTRAC 445",
                      "POWERTRAC 4455",
                      "PT-430 Plus",
                      "PT-435 Plus",
                      "PT-437",
                      "PT- EURO 37",
                      "PT- EURO 41",
                      "PT- EURO 42 PLUS",
                      "PT- EURO 45 PLUS",
                      "PT- EURO 50",
                      "PT- EURO 55",
                      "PT- EURO 60",
                      "PT-EURO 47",
                      "PT-EURO 55",
                      "PTALT 3500",
                      "PTALT 4000",
                      "PT_EURO_55",
                      "SOLIS 4215 2WD",
                      "SOLIS 4215 4WD",
                      "SOLIS 4215 EP",
                      "SOLIS 4415 2WD",
                      "SOLIS 4415 4WD",
                      "SOLIS 4515",
                      "SOLIS 5015 2WD",
                      "SWARAJ 717",
                      "SWARAJ 724",
                      "SWARAJ 735 FE",
                      "SWARAJ 744 FE",
                      "SWARAJ 744 XT",
                      "SWARAJ 825",
                      "SWARAJ 834 FE",
                      "SWARAJ 841",
                      "SWARAJ 843 XM",
                      "SWARAJ 855 FE",
                      "SWARAJ 960PS",
                      "SWARAJ 963",
                      "SWARAJ742XT",
                      "TAFE 30",
                      "TAFE 9500",
                      "TAFE 1030",
                      "TAFE 1035 PD",
                      "TAFE 1134",
                      "TAFE 5245",
                      "TAFE MF 246",
                      "TAFE 245 SMART",
                      "WORLDTRAC 60 RX",
                    ].map((String brand) {
                      return DropdownMenuItem<String>(
                        value: brand,
                        child: Text(
                          brand,
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                      );
                    }).toList(),
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                      hintStyle: GoogleFonts.roboto(
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
                  SizedBox(height: size.height * 0.03),

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
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
