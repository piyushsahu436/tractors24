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
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';


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

  Map<String, List<String>> tractors = {
    "Eicher": [
      "E-242", "E-5660", "E-551", "EIC557_4WD", "EIC650_4WD", "EIC - 650",
      "E-241", "E-312", "E-333", "E-364", "E-380", "E-480", "E-485", "E-548", "E-557", "E-368", "EIC-188",
      "EIC 5150", "EIC 650"
    ],
    "Escorts": [
      "FARMTRAC 40", "FARMTRAC 45", "FARMTRAC 6060", "FT 6050", "FT 6045 SM",
      "FRAMTRAC CHAMPION", "FT 6045 LM", "FRAMTRAC 44", "FT-60 Powermaxx 4 WD",
      "FT-6055 Powermaxx", "FT-6055 Powermaxx 4 WD", "FT70", "FARMTRAC 30 HERO",
      "FARMTRAC 60", "FARMTRAC 65", "FARMTRAC XP 37 CHAMPION", "FT 6055", "FARMTRAC 41",
      "FT-50", "FT-60 Powermaxx", "FT-50 Powermaxx", "Fram trac_39", "Fram trac_42",
      "FARMTRAC 35", "Atom 26 4WD"
    ],
    "John Deere": [
      "JD 5039", "JD 5038", "JD 5103", "JD 5045D MFWD", "JD 5104", "JD 5104 4WD",
      "JD 5050 E", "JD 5055 D", "JD 5204", "JD 5050 4WD", "JD 5310 4WD", "JD 5055 4WD",
      "JD 5036", "JD-5005", "JD 5305", "JD_5405", "JD 5405 4WD", "JD 5045 D",
      "JD 5042", "JD 5050D", "JD 5055 E", "JD 5310", "JD-5060", "JD-5210",
      "JD 5105", "JD 5041 C", "JD 5205", "5075E"
    ],
    "M&M": [
      "MAHINDRA 265 DI", "MAHINDRA 295 DI", "MAHINDRA 555 DI", "MAHINDRA 595 DI",
      "MAHINDRA 395 DI", "MAHINDRA 365", "MAHINDRA 215", "MAHINDRA 255 DI", "MAHINDRA 275 DI",
      "MAHINDRA 475 DI", "MAHINDRA 575 DI", "MAHINDRA 605 DI", "MAHINDRA 585", "MAHINDRA 415",
      "MAHINDRA 225", "MM 445 ARJUN", "275 Yuvo", "405 YUVO TECH +", "405 4WD YUVO TECH +"
    ],
    "New Holland": [
      "NH3510", "NH4010", "NH6010", "NH7500", "NH5620", "NH 3600-2 4WD",
      "NH3037", "NH3032", "NH3600", "NH3230", "NH3630", "NH4510", "NH4710",
      "NH5500", "NH 3600-2", "NH 3030"
    ],
    "Power Trac": [
      "POWERTRAC 4455", "PT- EURO 41", "PT-430 Plus", "PTALT 3500", "PTALT 4000",
      "POWERTRAC 425", "POWERTRAC 434", "POWERTRAC 445", "POWERTRAC 439", "PT-EURO 45 PLUS",
      "PT Euro 50", "PT-435 Plus", "PT-437", "PT- EURO 42 PLUS", "PT- EURO 37",
      "PT- EURO 55", "PT- EURO 60", "PT-EURO 47", "PT_EURO_55"
    ],
    "Preet": [
      "PREET-4549", "PREET-955", "PREET-3549"
    ],
    "Sonalika": [
      "DI-60 MM", "DI-60", "ITL 20", "ITL26G", "ITL32RX", "WORLDTRAC 60 RX", "ITL MM 39",
      "DI-47", "DI 740", "DI 42", "DI-35 MM", "DI-35 Rx", "DI-730", "DI-734", "DI-745III POWER PLUS",
      "DI-745III Rx POWER PLUS", "DI-750 III", "DI-750 III Rx", "ITL-50 MM", "DI - 55",
      "ITL 41 MM", "DI 35", "DI 42 RX", "DI 50", "Solis 5015 2wd"
    ],
    "Swaraj": [
      "SWARAJ 960PS", "SWARAJ 717", "SWARAJ 744 FE", "SWARAJ 724", "SWARAJ 735 FE",
      "SWARAJ 744 XT", "SWARAJ 834 FE", "SWARAJ 843 XM", "SWARAJ 855 FE", "SWARAJ 841",
      "SWARAJ742XT", "SWARAJ 825", "SWARAJ 963"
    ],
    "TAFE": [
      "TAFE 9500", "TAFE 1030", "TAFE1035 PD", "TAFE 5245", "TAFE 30", "MF 1035 DI R",
      "MF 1035 Mahashakti", "MF 241 DI Mahashakti", "MF 241 DI PD", "MF 245 DI", "MF 7250",
      "MF 9000 PD", "MF 241 TONNER", "MF 1035 DI TONNER", "TAFE 245 SMART", "TAFE 1134",
      "TAFE_MF_246", "MF 7235"
    ],
    "Kubota": [
      "MU5501 -4WD", "MU5502 - 2WD", "MU5502 - 4WD", "B2441", "MU4501- 2WD - STD", "MU4501- 4WD", "MU5501", "A211N"
    ],
    "Solis": [
      "SOLIS- 4515", "SOLIS 4215 2WD", "SOLIS 4215 4WD", "SOLIS 4215 EP", "SOLIS 4415 2WD", "SOLIS 4415 4WD"
    ],
    "TMTL (EICHER)": [
      "EIC 650"
    ]
  };
  List<String> regYear = [
    '2025', '2024', '2023', '2022', '2021', '2020', '2019', '2018', '2017',
    '2016', '2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008',
    '2007', '2006'
  ];

  String? selectedBrand;
  String? selectedModel;
  String? selectedYear;
  String? price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ADD POST',
          style: GoogleFonts.roboto(
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
                  DropdownButtonFormField<String>(
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
                    value: selectedBrand,
                    items: tractors.keys.map((brand) {
                      return DropdownMenuItem(value: brand, child: Text(brand));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBrand = value;
                        selectedModel = null; // Reset model when brand changes
                        price = null;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.01),

                  DropdownButtonFormField<String>(
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
                          color: const Color.fromRGBO(124, 139, 160, 1.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    value: selectedModel,
                    items: selectedBrand != null
                        ? tractors[selectedBrand!]!.map((model) {
                      return DropdownMenuItem(value: model, child: Text(model));
                    }).toList()
                        : [],
                    onChanged: (value) {
                      setState(() {
                        selectedModel = value;
                        price = null;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.01),

                  DropdownButtonFormField<String>(
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
                    value: selectedYear,
                    items: regYear.map((year) {
                      return DropdownMenuItem(value: year, child: Text(year));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                      },
                  ),
                  SizedBox(height: size.height * 0.01),

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
                                      brand: selectedBrand ?? '',
                                      model: selectedModel ?? '',
                                      horsePower:
                                          _horsepowersellerformController,
                                      RegNum: _registratiosellerformController,
                                      RegistrationYear:
                                          selectedYear ?? '',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}