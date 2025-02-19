import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/policies_screen.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';


class search extends StatefulWidget {
  const search({super.key, required this.pincode});
  final String pincode;

  @override
  State<search> createState() => _searchState();
}


Future<List<DocumentSnapshot>> _fetchTractors(String pincode) async {
  List<String> tractorIds = await searchTractorsByPincode(pincode);

  if (tractorIds.isEmpty) {
    return [];
  }

  List<Future<DocumentSnapshot>> futures = tractorIds.map((docId) {
    return FirebaseFirestore.instance.collection('tractors').doc(docId).get();
  }).toList();

  List<DocumentSnapshot> results = await Future.wait(futures);
  return results.where((doc) => doc.exists).toList();
}

Future<List<String>> searchTractorsByPincode(String pincode) async {
  String jsonString = await rootBundle.loadString('lib/data/pincode_data.json');
  List<dynamic> pincodeList = json.decode(jsonString);

  String? district;
  String? state;

  for (var entry in pincodeList) {
    if (entry["Pincode"] == pincode) {
      district = entry["District"];
      state = entry["StateName"];
      break;
    }
  }

  if (state == null) {
    print("Pincode not found. Searching by state...");
    return searchTractorsByStateOnly(); // New function to handle state search
  }

  print("Searching tractors in District: $district, State: $state");

  List<String> tractorIds = [];

  if (district != null) {
    QuerySnapshot districtQuery = await FirebaseFirestore.instance
        .collection('tractors')
        .where('location', isEqualTo: district)
        .get();
    tractorIds = districtQuery.docs.map((doc) => doc.id).toList();
  }

  if (tractorIds.isEmpty) {
    print("No results found in district. Searching in state: $state");
    QuerySnapshot stateQuery = await FirebaseFirestore.instance
        .collection('tractors')
        .where('state', isEqualTo: state)
        .get();
    tractorIds = stateQuery.docs.map((doc) => doc.id).toList();
  }

  return tractorIds;
}

Future<List<String>> searchTractorsByStateOnly() async {
  QuerySnapshot stateQuery = await FirebaseFirestore.instance
      .collection('tractors')
      .where('state', isNotEqualTo: "")
      .get();

  return stateQuery.docs.map((doc) => doc.id).toList();
}
final TextEditingController searchController = TextEditingController();
String searchQuery = '';

Stream<QuerySnapshot> getTractorsStream() {
  if (searchQuery.isEmpty) {
    return FirebaseFirestore.instance.collection('tractors').snapshots();
  } else {
    return FirebaseFirestore.instance
        .collection('tractors')
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
        .snapshots();
  }
}
class _searchState extends State<search> {
  final search = TextEditingController();
  final location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/vector7.png'),
                          fit: BoxFit.fill,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: headerTemp(text: ''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 20.0),
                    child: Text(
                      'Search Results :',
                      style: GoogleFonts.roboto(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  GridViewWidget(pincode: widget.pincode)
                ],
              ),
              Positioned(
                top: 120,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Brand Name',
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(124, 139, 160, 1.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search)),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      TextFormField(
                        onTap: () async {
                          List<Object> results = await searchTractorsByPincode(widget.pincode);
                          print(results); // Debugging, you can update UI with results
                        },
                        controller: location,
                        decoration: InputDecoration(
                            hintText: 'Location',
                            hintStyle: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: const Color.fromRGBO(124, 139, 160, 1.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.location_pin)),
                      )
                    ],
                  ),
                ),
              )
            ]),
            ),
        );
    }
}


class GridViewWidget extends StatelessWidget {
  final String pincode; // List of document IDs to fetch

  GridViewWidget({super.key, required this.pincode});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: getTractorsStream(),  // Fetch tractors based on document IDs
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          var tractors = snapshot.data!.docs;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.62,
            ),
            itemCount: tractors.length,
            itemBuilder: (context, index) {
              var tractor = tractors[index].data() as Map<String, dynamic>;

              List<String> imageUrls = (tractor['images'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
                  [];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>CarDetailsPage(
                            SellPrice:
                            tractor['expectedPrice']?.toString() ?? '',
                            brand: tractor['brand'] ?? '',
                            model: tractor['model'] ?? '',
                            RegYear: tractor['registrationYear'] ?? '',
                            Pincode: tractor['pincode']?.toString() ?? '',
                            HorsePower:
                            tractor['horsePower']?.toString() ?? '',
                            Hours: tractor['hoursDriven'] ?? '',
                            RegNum: tractor['registrationNumber'] ?? '',
                            InsStatus: tractor['insuranceStatus'] ?? '',
                            RearTire: tractor['rearTyreSize'] ?? '',
                            Address: tractor['location'] ?? '',
                            Break: tractor['brakes'] ?? '',
                            Transmission: tractor['transmissionType'] ?? '',
                            PTO: tractor['ptoHP'] ?? '',
                            CC: tractor['capacityCC'] ?? '',
                            Cooling: tractor['coolingSystem'] ?? '',
                            LiftingCapacity:
                            tractor['liftingCapacity'] ?? '',
                            SteeringType: tractor['steeringType'] ?? '',
                            ClutchType: tractor['Clutch Type'] ?? '',
                            OilCap: tractor['capacity'] ?? '',
                            RunningKM: tractor['Running KM'] ?? '',
                            Fuel: tractor['fuelType'] ?? '',
                            tractorId: tractor['tractorId'] ?? '',
                            imageUrls: (tractor['images'] as List<dynamic>?)
                                ?.map((e) => e.toString())
                                .toList() ??
                                [],
                            description: tractor['description'] ?? '',
                            state: tractor['state'] ?? "",
                            docId: '',

                          ))
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: Container(
                          height: size.height * 0.15,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12.0)),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (imageUrls.isNotEmpty)
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Image.network(
                                    imageUrls[0],
                                    fit: BoxFit.cover,
                                    color: Colors.black.withOpacity(0.3),
                                    colorBlendMode: BlendMode.darken,
                                  ),
                                ),
                              Center(
                                child: Image.network(
                                  imageUrls.isNotEmpty
                                      ? imageUrls[0]
                                      : 'assets/images/default.png',
                                  fit: BoxFit.contain,
                                  width: size.width * 0.9,
                                  height: size.height * 0.15,
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF003B8F),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              " Great Price ",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 7,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Image(
                                          image: AssetImage("assets/images/favIcon.png"),
                                          height: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${tractor['brand']} ${tractor['model']}',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF050B20),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: size.height * 0.007),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage("assets/images/locaIcon.png"),
                                        height: 12,
                                      ),
                                      SizedBox(width: size.width * 0.015),
                                      Text(
                                        tractor['location'] ?? 'Unknown',
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xFF414141),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage("assets/images/kmIcon.png"),
                                        height: 9,
                                      ),
                                      SizedBox(width: size.width * 0.015),
                                      Text(
                                        '${tractor['hoursDriven']} hr' ?? 'Unknown',
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xFF414141),
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.007),
                            Text(
                              '₹${tractor['expectedPrice']}' ?? 'Unknown',
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF414141),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

// Function to fetch tractor details using document IDs


}



// class GridViewWidget extends StatelessWidget {
//   final String pincode; // List of document IDs to fetch
//
//   GridViewWidget({super.key, required this.pincode});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//       child: FutureBuilder<List<DocumentSnapshot>>(
//         future: _fetchTractors(pincode), // Fetch tractors based on document IDs
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No data available"));
//           }
//
//           var tractors = snapshot.data!;
//
//           return GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10.0,
//               mainAxisSpacing: 10.0,
//               childAspectRatio: 0.62,
//             ),
//             itemCount: tractors.length,
//             itemBuilder: (context, index) {
//               var tractor = tractors[index].data() as Map<String, dynamic>;
//
//               List<String> imageUrls = (tractor['images'] as List<dynamic>?)
//                   ?.map((e) => e.toString())
//                   .toList() ??
//                   [];
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>CarDetailsPage(
//                         SellPrice:
//                         tractor['expectedPrice']?.toString() ?? '',
//                         brand: tractor['brand'] ?? '',
//                         model: tractor['model'] ?? '',
//                         RegYear: tractor['registrationYear'] ?? '',
//                         Pincode: tractor['pincode']?.toString() ?? '',
//                         HorsePower:
//                         tractor['horsePower']?.toString() ?? '',
//                         Hours: tractor['hoursDriven'] ?? '',
//                         RegNum: tractor['registrationNumber'] ?? '',
//                         InsStatus: tractor['insuranceStatus'] ?? '',
//                         RearTire: tractor['rearTyreSize'] ?? '',
//                         Address: tractor['location'] ?? '',
//                         Break: tractor['brakes'] ?? '',
//                         Transmission: tractor['transmissionType'] ?? '',
//                         PTO: tractor['ptoHP'] ?? '',
//                         CC: tractor['capacityCC'] ?? '',
//                         Cooling: tractor['coolingSystem'] ?? '',
//                         LiftingCapacity:
//                         tractor['liftingCapacity'] ?? '',
//                         SteeringType: tractor['steeringType'] ?? '',
//                         ClutchType: tractor['Clutch Type'] ?? '',
//                         OilCap: tractor['capacity'] ?? '',
//                         RunningKM: tractor['Running KM'] ?? '',
//                         Fuel: tractor['fuelType'] ?? '',
//                         tractorId: tractor['tractorId'] ?? '',
//                         imageUrls: (tractor['images'] as List<dynamic>?)
//                             ?.map((e) => e.toString())
//                             .toList() ??
//                             [],
//                         description: tractor['description'] ?? '',
//                         state: tractor['state'] ?? "",
//                       ))
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         offset: Offset(0, 2),
//                         blurRadius: 6,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(12.0),
//                         ),
//                         child: Container(
//                           height: size.height * 0.15,
//                           width: double.infinity,
//                           decoration: const BoxDecoration(
//                             borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(12.0)),
//                           ),
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               if (imageUrls.isNotEmpty)
//                                 ImageFiltered(
//                                   imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                                   child: Image.network(
//                                     imageUrls[0],
//                                     fit: BoxFit.cover,
//                                     color: Colors.black.withOpacity(0.3),
//                                     colorBlendMode: BlendMode.darken,
//                                   ),
//                                 ),
//                               Center(
//                                 child: Image.network(
//                                   imageUrls.isNotEmpty
//                                       ? imageUrls[0]
//                                       : 'assets/images/default.png',
//                                   fit: BoxFit.contain,
//                                   width: size.width * 0.9,
//                                   height: size.height * 0.15,
//                                 ),
//                               ),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 12),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: const Color(0xFF003B8F),
//                                             borderRadius: BorderRadius.circular(20),
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Text(
//                                               " Great Price ",
//                                               style: GoogleFonts.roboto(
//                                                 color: Colors.white,
//                                                 fontSize: 7,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const Image(
//                                           image: AssetImage("assets/images/favIcon.png"),
//                                           height: 18,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${tractor['brand']} ${tractor['model']}',
//                               style: GoogleFonts.roboto(
//                                 color: const Color(0xFF050B20),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: size.height * 0.007),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       const Image(
//                                         image: AssetImage("assets/images/locaIcon.png"),
//                                         height: 12,
//                                       ),
//                                       SizedBox(width: size.width * 0.015),
//                                       Text(
//                                         tractor['location'] ?? 'Unknown',
//                                         style: GoogleFonts.roboto(
//                                           color: const Color(0xFF414141),
//                                           fontSize: 9,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       const Image(
//                                         image: AssetImage("assets/images/kmIcon.png"),
//                                         height: 9,
//                                       ),
//                                       SizedBox(width: size.width * 0.015),
//                                       Text(
//                                         '${tractor['hoursDriven']} hr' ?? 'Unknown',
//                                         style: GoogleFonts.roboto(
//                                           color: const Color(0xFF414141),
//                                           fontSize: 9,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: size.height * 0.007),
//                             Text(
//                               '₹${tractor['expectedPrice']}' ?? 'Unknown',
//                               style: GoogleFonts.roboto(
//                                 color: const Color(0xFF414141),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // Function to fetch tractor details using document IDs
//
//
// }
