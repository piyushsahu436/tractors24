import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:tractors24/screens/search.dart';
import 'package:tractors24/splash_screen/SplashScreen2.dart';



class anime extends StatefulWidget {
  const anime({super.key});

  @override
  State<anime> createState() => _animeState();
}
late RiveAnimationController _controller;


class _animeState extends State<anime> {

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Timeline 1');// Check animation name in Rive file

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const search(pincode: '452009')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
        body: Stack(
          children: [
            // At the end of the video i will show you
            // How to create that animation on Rive
            // Let's add blur

            RiveAnimation.asset("assets/animations/splash", fit: BoxFit.cover,controllers: [_controller],),
          ], // Stack
        ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
//
// class anime extends StatefulWidget {
//   const anime({super.key});
//
//   @override
//   State<anime> createState() => _animeState();
// }
//
// class _animeState extends State<anime> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(height: size.height*2.5 ,width: size.width *2.5,
//         child: Lottie.network('https://cdn.lottielab.com/l/CoTaKea132USMq.json'),
//       )
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter/material.dart';
// import 'package:csv/csv.dart';
//
//
// class TractorPriceService {
//   List<Map<String, dynamic>> priceData = [];
//
//   // Load CSV data
//   Future<void> loadCsvData() async {
//     try {
//       final rawData = await rootBundle.loadString('assets/data/priceSheet.csv');
//       List<List<dynamic>> csvTable = const CsvToListConverter().convert(
//           rawData);
//
//       if (csvTable.isEmpty) {
//         print("CSV file is empty!");
//         return;
//       }
//
//       // Extract headers (first row)
//       List<String> headers = csvTable[0].map((e) => e.toString()).toList();
//       print("Headers: $headers"); // Debugging
//
//       // Convert rows into a list of maps
//       priceData = csvTable.skip(1).map((row) {
//         Map<String, dynamic> rowMap = {};
//         for (int i = 0; i < headers.length; i++) {
//           rowMap[headers[i]] = row[i];
//         }
//         return rowMap;
//       }).toList();
//
//       print("Loaded Data: ${priceData.take(3)}"); // Print first 3 rows
//     } catch (e) {
//       print("Error loading CSV: $e");
//     }
//   }
//
//
//   // Fetch price based on brand, model, and year
//   String? getTractorPrice(String brand, String model, String year) {
//     int yearInt = int.tryParse(year) ?? 0;
//
//     if (yearInt < 2006 || yearInt > 2025) {
//       print("❌ Invalid year: $year");
//       return "Year out of range";
//     }
//
//     print("🔍 Searching: Brand = $brand, Model = $model, Year = $yearInt");
//
//     // Find row matching MAKE and MODEL (trim spaces)
//     final found = priceData.firstWhere(
//           (row) => row['MAKE'].toString().trim().toLowerCase() == brand.trim().toLowerCase() &&
//           row['MODEL'].toString().trim().toLowerCase() == model.trim().toLowerCase(),
//       orElse: () => {},
//     );
//
//     if (found.isNotEmpty) {
//       String yearKey = yearInt.toString();
//       if (found.containsKey(yearKey)) {
//         print("💰 Price found: ${found[yearKey]}");
//         return found[yearKey].toString();
//       }
//     }
//
//     print("❌ Price not found");
//     return "Price not found";
//   }
//
// }
//
// class TractorPriceFinder extends StatefulWidget {
//   @override
//   _TractorPriceFinderState createState() => _TractorPriceFinderState();
// }
//
// class _TractorPriceFinderState extends State<TractorPriceFinder> {
//   List<Map<String, dynamic>> priceData = [];
//   Set<String> brands = {}; // Use Set to keep unique brands
//   List<String> models = [];
//   List<String> years = [];
//
//   String? selectedBrand;
//   String? selectedModel;
//   String? selectedYear;
//   String? price;
//
//   @override
//   void initState() {
//     super.initState();
//     loadCSV();
//   }
//
//   // 📌 Load CSV file
//   Future<void> loadCSV() async {
//     final rawData = await rootBundle.loadString('assets/data/priceSheet.csv');
//     List<List<dynamic>> csvTable = const CsvToListConverter(eol: "\n").convert(rawData);
//
//     if (csvTable.isEmpty) {
//       print("⚠️ CSV is empty or not loaded correctly!");
//       return;
//     }
//
//     // Extract headers (first row)
//     List<String> headers = csvTable[0].map((e) => e.toString().trim()).toList();
//     print("📌 Headers: $headers");
//
//     years = headers.sublist(2); // Extract years dynamically
//     print("📅 Available years: $years");
//
//     List<Map<String, dynamic>> tempData = [];
//     Set<String> uniqueBrands = {}; // Store unique brands
//
//     for (var row in csvTable.sublist(1)) {
//       if (row.length < 2) continue; // Skip invalid rows
//
//       // Trim MAKE and MODEL values
//       String make = row[0].toString().trim();
//       String model = row[1].toString().trim();
//
//       if (make.isEmpty || model.isEmpty) continue; // Skip empty rows
//
//       // Fix partial brand name issue
//       if (make.length < 3) {
//         print("⚠️ Suspected issue: MAKE value too short → '$make'");
//         continue;
//       }
//
//       // Create a row map
//       Map<String, dynamic> rowData = {'MAKE': make, 'MODEL': model};
//
//       for (int i = 2; i < row.length; i++) {
//         rowData[headers[i]] = row[i]; // Store year-price mapping
//       }
//
//       tempData.add(rowData);
//       uniqueBrands.add(make); // Ensure unique brands
//     }
//
//     setState(() {
//       priceData = tempData;
//       brands = uniqueBrands;
//     });
//
//     print("✅ Brands loaded: $brands");
//   }
//
//
//   // 📌 Fetch models based on selected brand
//   void updateModels() {
//     if (selectedBrand == null) return;
//
//     List<String> filteredModels = priceData
//         .where((item) => item['MAKE'] == selectedBrand)
//         .map((item) => item['MODEL'].toString())
//         .toList();
//
//     setState(() {
//       models = filteredModels;
//       selectedModel = null;
//       price = null;
//     });
//
//     print("✅ Models for $selectedBrand: $models");
//   }
//
//   // 📌 Get price based on brand, model, and year
//   void fetchPrice() {
//     if (selectedBrand == null || selectedModel == null || selectedYear == null) return;
//
//     print("🔍 Searching: Brand = $selectedBrand, Model = $selectedModel, Year = $selectedYear");
//
//     final match = priceData.firstWhere(
//           (row) =>
//       row['MAKE'] == selectedBrand &&
//           row['MODEL'] == selectedModel,
//       orElse: () => {},
//     );
//
//     if (match.isNotEmpty && match.containsKey(selectedYear)) {
//       setState(() {
//         price = match[selectedYear].toString();
//       });
//       print("✅ Price found: $price");
//     } else {
//       setState(() {
//         price = "Price not found";
//       });
//       print("❌ Price not found");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Tractor Price Finder")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Brand Dropdown
//             DropdownButton<String>(
//               value: selectedBrand,
//               hint: Text("Select Brand"),
//               isExpanded: true,
//               items: brands.map((String brand) {
//                 return DropdownMenuItem<String>(
//                   value: brand,
//                   child: Text(brand),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedBrand = value;
//                   updateModels();
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//
//             // Model Dropdown
//             DropdownButton<String>(
//               value: selectedModel,
//               hint: Text("Select Model"),
//               isExpanded: true,
//               items: models.map((String model) {
//                 return DropdownMenuItem<String>(
//                   value: model,
//                   child: Text(model),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedModel = value;
//                   price = null;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//
//             // Year Dropdown
//             DropdownButton<String>(
//               value: selectedYear,
//               hint: Text("Select Year"),
//               isExpanded: true,
//               items: years.map((String year) {
//                 return DropdownMenuItem<String>(
//                   value: year,
//                   child: Text(year),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedYear = value;
//                   fetchPrice();
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//
//             // Display Price
//             Text(
//               price == null ? "Select options to see price" : "💰 Price: $price",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // class TractorDropdownExample extends StatefulWidget {
// //   const TractorDropdownExample({super.key});
// //
// //   @override
// //   State<TractorDropdownExample> createState() => _TractorDropdownExampleState();
// // }
//
// // class _TractorDropdownExampleState extends State<TractorDropdownExample> {
// //   final TractorPriceService tractorPriceService = TractorPriceService();
// //
// //   Map<String, List<String>> tractors = {
// //     "Eicher": [
// //       "E-242", "E-5660", "E-551", "EIC557_4WD", "EIC650_4WD", "EIC - 650",
// //       "E-241", "E-312", "E-333", "E-364", "E-380", "E-480", "E-485", "E-548", "E-557", "E-368", "EIC-188",
// //       "EIC 5150", "EIC 650"
// //     ],
// //     "Escorts": [
// //       "FARMTRAC 40", "FARMTRAC 45", "FARMTRAC 6060", "FT 6050", "FT 6045 SM",
// //       "FRAMTRAC CHAMPION", "FT 6045 LM", "FRAMTRAC 44", "FT-60 Powermaxx 4 WD",
// //       "FT-6055 Powermaxx", "FT-6055 Powermaxx 4 WD", "FT70", "FARMTRAC 30 HERO",
// //       "FARMTRAC 60", "FARMTRAC 65", "FARMTRAC XP 37 CHAMPION", "FT 6055", "FARMTRAC 41",
// //       "FT-50", "FT-60 Powermaxx", "FT-50 Powermaxx", "Fram trac_39", "Fram trac_42",
// //       "FARMTRAC 35", "Atom 26 4WD"
// //     ],
// //     "John Deere": [
// //       "JD 5039", "JD 5038", "JD 5103", "JD 5045D MFWD", "JD 5104", "JD 5104 4WD",
// //       "JD 5050 E", "JD 5055 D", "JD 5204", "JD 5050 4WD", "JD 5310 4WD", "JD 5055 4WD",
// //       "JD 5036", "JD-5005", "JD 5305", "JD_5405", "JD 5405 4WD", "JD 5045 D",
// //       "JD 5042", "JD 5050D", "JD 5055 E", "JD 5310", "JD-5060", "JD-5210",
// //       "JD 5105", "JD 5041 C", "JD 5205", "5075E"
// //     ],
// //     "M&M": [
// //       "MAHINDRA 265 DI", "MAHINDRA 295 DI", "MAHINDRA 555 DI", "MAHINDRA 595 DI",
// //       "MAHINDRA 395 DI", "MAHINDRA 365", "MAHINDRA 215", "MAHINDRA 255 DI", "MAHINDRA 275 DI",
// //       "MAHINDRA 475 DI", "MAHINDRA 575 DI", "MAHINDRA 605 DI", "MAHINDRA 585", "MAHINDRA 415",
// //       "MAHINDRA 225", "MM 445 ARJUN", "275 Yuvo", "405 YUVO TECH +", "405 4WD YUVO TECH +"
// //     ],
// //     "New Holland": [
// //       "NH3510", "NH4010", "NH6010", "NH7500", "NH5620", "NH 3600-2 4WD",
// //       "NH3037", "NH3032", "NH3600", "NH3230", "NH3630", "NH4510", "NH4710",
// //       "NH5500", "NH 3600-2", "NH 3030"
// //     ],
// //     "Power Trac": [
// //       "POWERTRAC 4455", "PT- EURO 41", "PT-430 Plus", "PTALT 3500", "PTALT 4000",
// //       "POWERTRAC 425", "POWERTRAC 434", "POWERTRAC 445", "POWERTRAC 439", "PT-EURO 45 PLUS",
// //       "PT Euro 50", "PT-435 Plus", "PT-437", "PT- EURO 42 PLUS", "PT- EURO 37",
// //       "PT- EURO 55", "PT- EURO 60", "PT-EURO 47", "PT_EURO_55"
// //     ],
// //     "Preet": [
// //       "PREET-4549", "PREET-955", "PREET-3549"
// //     ],
// //     "Sonalika": [
// //       "DI-60 MM", "DI-60", "ITL 20", "ITL26G", "ITL32RX", "WORLDTRAC 60 RX", "ITL MM 39",
// //       "DI-47", "DI 740", "DI 42", "DI-35 MM", "DI-35 Rx", "DI-730", "DI-734", "DI-745III POWER PLUS",
// //       "DI-745III Rx POWER PLUS", "DI-750 III", "DI-750 III Rx", "ITL-50 MM", "DI - 55",
// //       "ITL 41 MM", "DI 35", "DI 42 RX", "DI 50", "Solis 5015 2wd"
// //     ],
// //     "Swaraj": [
// //       "SWARAJ 960PS", "SWARAJ 717", "SWARAJ 744 FE", "SWARAJ 724", "SWARAJ 735 FE",
// //       "SWARAJ 744 XT", "SWARAJ 834 FE", "SWARAJ 843 XM", "SWARAJ 855 FE", "SWARAJ 841",
// //       "SWARAJ742XT", "SWARAJ 825", "SWARAJ 963"
// //     ],
// //     "TAFE": [
// //       "TAFE 9500", "TAFE 1030", "TAFE1035 PD", "TAFE 5245", "TAFE 30", "MF 1035 DI R",
// //       "MF 1035 Mahashakti", "MF 241 DI Mahashakti", "MF 241 DI PD", "MF 245 DI", "MF 7250",
// //       "MF 9000 PD", "MF 241 TONNER", "MF 1035 DI TONNER", "TAFE 245 SMART", "TAFE 1134",
// //       "TAFE_MF_246", "MF 7235"
// //     ],
// //     "Kubota": [
// //       "MU5501 -4WD", "MU5502 - 2WD", "MU5502 - 4WD", "B2441", "MU4501- 2WD - STD", "MU4501- 4WD", "MU5501", "A211N"
// //     ],
// //     "Solis": [
// //       "SOLIS- 4515", "SOLIS 4215 2WD", "SOLIS 4215 4WD", "SOLIS 4215 EP", "SOLIS 4415 2WD", "SOLIS 4415 4WD"
// //     ],
// //     "TMTL (EICHER)": [
// //       "EIC 650"
// //     ]
// //   };
// //   List<String> regYear = [
// //     '2025', '2024', '2023', '2022', '2021', '2020', '2019', '2018', '2017',
// //     '2016', '2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008',
// //     '2007', '2006'
// //   ];
// //
// //   String? selectedBrand;
// //   String? selectedModel;
// //   String? selectedYear;
// //   String? price;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     tractorPriceService.loadCsvData();
// //   }
// //
// //   void updatePrice() {
// //     if (selectedBrand != null && selectedModel != null && selectedYear != null) {
// //       setState(() {
// //         price = tractorPriceService.getTractorPrice(selectedBrand!, selectedModel!, selectedYear!) ?? "Price not found";
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Cascading Dropdown Example")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             DropdownButtonFormField<String>(
// //               decoration: const InputDecoration(
// //                 labelText: "Select Brand",
// //                 border: OutlineInputBorder(),
// //               ),
// //               value: selectedBrand,
// //               items: tractors.keys.map((brand) {
// //                 return DropdownMenuItem(
// //                   value: brand,
// //                   child: Text(brand),
// //                 );
// //               }).toList(),
// //               onChanged: (value) {
// //                 setState(() {
// //                   selectedBrand = value;
// //                   selectedModel = null; // Reset model when brand changes
// //                 });
// //               },
// //             ),
// //             const SizedBox(height: 20),
// //
// //             DropdownButtonFormField<String>(
// //               decoration: const InputDecoration(
// //                 labelText: "Select Model",
// //                 border: OutlineInputBorder(),
// //               ),
// //               value: selectedModel,
// //               items: selectedBrand != null
// //                   ? tractors[selectedBrand!]!.map((model) {
// //                 return DropdownMenuItem(
// //                   value: model,
// //                   child: Text(model),
// //                 );
// //               }).toList()
// //                   : [],
// //               onChanged: (value) {
// //                 setState(() {
// //                   selectedModel = value;
// //                 });
// //               },
// //             ),
// //             const SizedBox(height: 20),
// //
// //             DropdownButtonFormField<String>(
// //               decoration: const InputDecoration(
// //                 labelText: "Select Registration Year",
// //                 border: OutlineInputBorder(),
// //               ),
// //               value: selectedYear,
// //               items: regYear.map((year) {
// //                 return DropdownMenuItem(
// //                   value: year,
// //                   child: Text(year),
// //                 );
// //               }).toList(),
// //               onChanged: (value) {
// //                 setState(() {
// //                   selectedYear = value;
// //                 });
// //                 updatePrice();
// //               },
// //             ),
// //             const SizedBox(height: 20),
// //
// //             Text(
// //               price ?? "Select all fields to fetch price",
// //               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // import 'package:flutter/material.dart';
// // //
// // // class TractorDropdownExample extends StatefulWidget {
// // //   @override
// // //   _TractorDropdownExampleState createState() => _TractorDropdownExampleState();
// // // }
// // //
// // // class _TractorDropdownExampleState extends State<TractorDropdownExample> {
// // //   // List of brands and their corresponding models
// // //   Map<String, List<String>> tractors = {
// // //     "Eicher": [
// // //       "E-242", "E-5660", "E-551", "EIC557_4WD", "EIC650_4WD", "EIC - 650",
// // //       "E-241", "E-312", "E-333", "E-364", "E-380", "E-480", "E-485", "E-548", "E-557", "E-368", "EIC-188",
// // //       "EIC 5150", "EIC 650"
// // //     ],
// // //     "Escorts": [
// // //       "FARMTRAC 40", "FARMTRAC 45", "FARMTRAC 6060", "FT 6050", "FT 6045 SM",
// // //       "FRAMTRAC CHAMPION", "FT 6045 LM", "FRAMTRAC 44", "FT-60 Powermaxx 4 WD",
// // //       "FT-6055 Powermaxx", "FT-6055 Powermaxx 4 WD", "FT70", "FARMTRAC 30 HERO",
// // //       "FARMTRAC 60", "FARMTRAC 65", "FARMTRAC XP 37 CHAMPION", "FT 6055", "FARMTRAC 41",
// // //       "FT-50", "FT-60 Powermaxx", "FT-50 Powermaxx", "Fram trac_39", "Fram trac_42",
// // //       "FARMTRAC 35", "Atom 26 4WD"
// // //     ],
// // //     "John Deere": [
// // //       "JD 5039", "JD 5038", "JD 5103", "JD 5045D MFWD", "JD 5104", "JD 5104 4WD",
// // //       "JD 5050 E", "JD 5055 D", "JD 5204", "JD 5050 4WD", "JD 5310 4WD", "JD 5055 4WD",
// // //       "JD 5036", "JD-5005", "JD 5305", "JD_5405", "JD 5405 4WD", "JD 5045 D",
// // //       "JD 5042", "JD 5050D", "JD 5055 E", "JD 5310", "JD-5060", "JD-5210",
// // //       "JD 5105", "JD 5041 C", "JD 5205", "5075E"
// // //     ],
// // //     "M&M": [
// // //       "MAHINDRA 265 DI", "MAHINDRA 295 DI", "MAHINDRA 555 DI", "MAHINDRA 595 DI",
// // //       "MAHINDRA 395 DI", "MAHINDRA 365", "MAHINDRA 215", "MAHINDRA 255 DI", "MAHINDRA 275 DI",
// // //       "MAHINDRA 475 DI", "MAHINDRA 575 DI", "MAHINDRA 605 DI", "MAHINDRA 585", "MAHINDRA 415",
// // //       "MAHINDRA 225", "MM 445 ARJUN", "275 Yuvo", "405 YUVO TECH +", "405 4WD YUVO TECH +"
// // //     ],
// // //     "New Holland": [
// // //       "NH3510", "NH4010", "NH6010", "NH7500", "NH5620", "NH 3600-2 4WD",
// // //       "NH3037", "NH3032", "NH3600", "NH3230", "NH3630", "NH4510", "NH4710",
// // //       "NH5500", "NH 3600-2", "NH 3030"
// // //     ],
// // //     "Power Trac": [
// // //       "POWERTRAC 4455", "PT- EURO 41", "PT-430 Plus", "PTALT 3500", "PTALT 4000",
// // //       "POWERTRAC 425", "POWERTRAC 434", "POWERTRAC 445", "POWERTRAC 439", "PT-EURO 45 PLUS",
// // //       "PT Euro 50", "PT-435 Plus", "PT-437", "PT- EURO 42 PLUS", "PT- EURO 37",
// // //       "PT- EURO 55", "PT- EURO 60", "PT-EURO 47", "PT_EURO_55"
// // //     ],
// // //     "Preet": [
// // //       "PREET-4549", "PREET-955", "PREET-3549"
// // //     ],
// // //     "Sonalika": [
// // //       "DI-60 MM", "DI-60", "ITL 20", "ITL26G", "ITL32RX", "WORLDTRAC 60 RX", "ITL MM 39",
// // //       "DI-47", "DI 740", "DI 42", "DI-35 MM", "DI-35 Rx", "DI-730", "DI-734", "DI-745III POWER PLUS",
// // //       "DI-745III Rx POWER PLUS", "DI-750 III", "DI-750 III Rx", "ITL-50 MM", "DI - 55",
// // //       "ITL 41 MM", "DI 35", "DI 42 RX", "DI 50", "Solis 5015 2wd"
// // //     ],
// // //     "Swaraj": [
// // //       "SWARAJ 960PS", "SWARAJ 717", "SWARAJ 744 FE", "SWARAJ 724", "SWARAJ 735 FE",
// // //       "SWARAJ 744 XT", "SWARAJ 834 FE", "SWARAJ 843 XM", "SWARAJ 855 FE", "SWARAJ 841",
// // //       "SWARAJ742XT", "SWARAJ 825", "SWARAJ 963"
// // //     ],
// // //     "TAFE": [
// // //       "TAFE 9500", "TAFE 1030", "TAFE1035 PD", "TAFE 5245", "TAFE 30", "MF 1035 DI R",
// // //       "MF 1035 Mahashakti", "MF 241 DI Mahashakti", "MF 241 DI PD", "MF 245 DI", "MF 7250",
// // //       "MF 9000 PD", "MF 241 TONNER", "MF 1035 DI TONNER", "TAFE 245 SMART", "TAFE 1134",
// // //       "TAFE_MF_246", "MF 7235"
// // //     ],
// // //     "Kubota": [
// // //       "MU5501 -4WD", "MU5502 - 2WD", "MU5502 - 4WD", "B2441", "MU4501- 2WD - STD", "MU4501- 4WD", "MU5501", "A211N"
// // //     ],
// // //     "Solis": [
// // //       "SOLIS- 4515", "SOLIS 4215 2WD", "SOLIS 4215 4WD", "SOLIS 4215 EP", "SOLIS 4415 2WD", "SOLIS 4415 4WD"
// // //     ],
// // //     "TMTL (EICHER)": [
// // //       "EIC 650"
// // //     ]
// // //   };
// // //   List<String> regYear = [
// // //     '2025', '2024', '2023', '2022', '2021', '2020', '2019', '2018', '2017',
// // //     '2016', '2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008',
// // //     '2007', '2006'
// // //   ];
// // //
// // //
// // //
// // //   // Selected values
// // //   String? selectedBrand;
// // //   String? selectedModel;
// // //   String? selectedYear;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Cascading Dropdown Example")),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // Brand Dropdown
// // //             DropdownButtonFormField<String>(
// // //               decoration: const InputDecoration(
// // //                 labelText: "Select Brand",
// // //                 border: OutlineInputBorder(),
// // //               ),
// // //               value: selectedBrand,
// // //               items: tractors.keys.map((brand) {
// // //                 return DropdownMenuItem(
// // //                   value: brand,
// // //                   child: Text(brand),
// // //                 );
// // //               }).toList(),
// // //               onChanged: (value) {
// // //                 setState(() {
// // //                   selectedBrand = value;
// // //                   selectedModel = null; // Reset model when brand changes
// // //                 });
// // //               },
// // //             ),
// // //             const SizedBox(height: 20),
// // //
// // //             // Model Dropdown
// // //             DropdownButtonFormField<String>(
// // //               decoration: const InputDecoration(
// // //                 labelText: "Select Model",
// // //                 border: OutlineInputBorder(),
// // //               ),
// // //               value: selectedModel,
// // //               items: selectedBrand != null
// // //                   ? tractors[selectedBrand!]!.map((model) {
// // //                 return DropdownMenuItem(
// // //                   value: model,
// // //                   child: Text(model),
// // //                 );
// // //               }).toList()
// // //                   : [], // Empty if no brand is selected
// // //               onChanged: (value) {
// // //                 setState(() {
// // //                   selectedModel = value;
// // //                 });
// // //               },
// // //             ),
// // //             DropdownButtonFormField<String>(
// // //               decoration: const InputDecoration(
// // //                 labelText: "Select Registration Year",
// // //                 border: OutlineInputBorder(),
// // //               ),
// // //               value: selectedYear,
// // //               items: regYear.map((year) {
// // //                 return DropdownMenuItem(
// // //                   value: year,
// // //                   child: Text(year),
// // //                 );
// // //               }).toList(),
// // //               onChanged: (value) {
// // //                 setState(() {
// // //                   selectedYear = value;
// // //                 });
// // //               },
// // //             ),
// // //
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // // import 'package:animated_custom_dropdown/custom_dropdown.dart';
// // // // import 'package:flutter/material.dart';
// // // //
// // // // class CustomDropdownExample extends StatefulWidget {
// // // //   const CustomDropdownExample({super.key});
// // // //
// // // //   @override
// // // //   State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
// // // // }
// // // //
// // // // class _CustomDropdownExampleState extends State<CustomDropdownExample> {
// // // //   final SingleSelectController<String> search = SingleSelectController<String>(null);
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: const Text("Dropdown Example")),
// // // //       body: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           children: [
// // // //             Container(
// // // //               padding: const EdgeInsets.symmetric(horizontal: 12),
// // // //               decoration: BoxDecoration(
// // // //                 border: Border.all(color: Colors.grey),
// // // //                 borderRadius: BorderRadius.circular(8),
// // // //               ),
// // // //               child: CustomDropdown.search(
// // // //                 items: const ["Eicher",
// // // //                   "Escorts",
// // // //                   "John Deere",
// // // //                   "M&M",
// // // //                   "New Holland",
// // // //                   "Power Trac",
// // // //                   "Preet",
// // // //                   "Sonalika",
// // // //                   "Swaraj",
// // // //                   "TAFE",
// // // //                   "Kubota",
// // // //                   "Solis",
// // // //                   "TMTL (Eicher)"],
// // // //                 hintText: 'Search Job Role...',
// // // //                 onChanged: (value) {
// // // //                   search.value = value; // Ensure value is updated
// // // //                   print("Selected: $value");
// // // //                 },
// // // //                 searchHintText: 'Type to search...',
// // // //                 controller: search,
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // //
// // // //
// // // //
// // // // class test extends StatefulWidget {
// // // //   const test({super.key});
// // // //
// // // //   @override
// // // //   State<test> createState() => _testState();
// // // // }
// // // //
// // // // class _testState extends State<test> {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       body:Column(mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: const [
// // // //           Padding(
// // // //             padding: EdgeInsets.all(8.0),
// // // //             child: CustomDropdownExample(),
// // // //           )
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
