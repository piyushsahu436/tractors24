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
  final TextEditingController OurPriceController = TextEditingController();
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

  List<Map<String, dynamic>> priceData = [];
  Set<String> brands = {}; // Use Set to keep unique brands
  List<String> models = [];
  List<String> years = [];

  String? selectedBrand;
  String? selectedModel;
  String? selectedYear;
  String? price;

  @override
  void initState() {
    super.initState();
    loadCSV();
  }

  Future<void> loadCSV() async {
    final rawData = await rootBundle.loadString('assets/data/priceSheet.csv');
    List<List<dynamic>> csvTable =
        const CsvToListConverter(eol: "\n").convert(rawData);

    if (csvTable.isEmpty) {
      print("⚠️ CSV is empty or not loaded correctly!");
      return;
    }

    // Extract headers (first row)
    List<String> headers = csvTable[0].map((e) => e.toString().trim()).toList();
    print("📌 Headers: $headers");

    years = headers.sublist(2); // Extract years dynamically
    print("📅 Available years: $years");

    List<Map<String, dynamic>> tempData = [];
    Set<String> uniqueBrands = {}; // Store unique brands

    for (var row in csvTable.sublist(1)) {
      if (row.length < 2) continue; // Skip invalid rows

      // Trim MAKE and MODEL values
      String make = row[0].toString().trim();
      String model = row[1].toString().trim();

      if (make.isEmpty || model.isEmpty) continue; // Skip empty rows

      // Fix partial brand name issue
      if (make.length < 3) {
        print("⚠️ Suspected issue: MAKE value too short → '$make'");
        continue;
      }

      // Create a row map
      Map<String, dynamic> rowData = {'MAKE': make, 'MODEL': model};

      for (int i = 2; i < row.length; i++) {
        rowData[headers[i]] = row[i]; // Store year-price mapping
      }

      tempData.add(rowData);
      uniqueBrands.add(make); // Ensure unique brands
    }

    setState(() {
      priceData = tempData;
      brands = uniqueBrands;
    });

    print("✅ Brands loaded: $brands");
  }

  // 📌 Fetch models based on selected brand
  void updateModels() {
    if (selectedBrand == null) return;

    List<String> filteredModels = priceData
        .where((item) => item['MAKE'] == selectedBrand)
        .map((item) => item['MODEL'].toString())
        .toList();

    setState(() {
      models = filteredModels;
      selectedModel = null;
      price = null;
    });

    print("✅ Models for $selectedBrand: $models");
  }

  // 📌 Get price based on brand, model, and year
  void fetchPrice() {
    if (selectedBrand == null || selectedModel == null || selectedYear == null)
      return;

    print(
        "🔍 Searching: Brand = $selectedBrand, Model = $selectedModel, Year = $selectedYear");

    final match = priceData.firstWhere(
      (row) => row['MAKE'] == selectedBrand && row['MODEL'] == selectedModel,
      orElse: () => {},
    );

    if (match.isNotEmpty && match.containsKey(selectedYear)) {
      setState(() {
        price = '₹ ${match[selectedYear].toString()}';
        OurPriceController.text = price!;
      });
      print("✅ Price found: $price");
    } else {
      setState(() {
        price = "Price not found";
      });
      print("❌ Price not found");
    }
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
                                : 1,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: selectedImages.isNotEmpty
                                        ? FileImage(selectedImages[index])
                                            as ImageProvider
                                        : const AssetImage(
                                            'assets/images/Rectangle 23807.png'),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                    hint: Text("Select Brand"),
                    isExpanded: true,
                    items: brands.map((String brand) {
                      return DropdownMenuItem<String>(
                        value: brand,
                        child: Text(brand),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBrand = value;
                        updateModels();
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
                    hint: Text("Select Model"),
                    isExpanded: true,
                    items: models.map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model),
                      );
                    }).toList(),
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
                    hint: Text("Select Year"),
                    isExpanded: true,
                    items: years.map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                        fetchPrice();
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.01),

                  TextField(
                    controller: OurPriceController,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/rupee.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      hintText: 'Our Price',
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
                          'assets/icons/rupee.png',
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
                                      RegistrationYear: selectedYear ?? '',
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
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
