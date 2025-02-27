import 'dart:ui';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  const search({super.key,});


  @override
  State<search> createState() => _searchState();
}

// Future<List<DocumentSnapshot>> _fetchTractors(String pincode) async {
//   List<String> tractorIds = await searchTractorsByPincode(pincode);
//
//   if (tractorIds.isEmpty) {
//     return [];
//   }
//
//   List<Future<DocumentSnapshot>> futures = tractorIds.map((docId) {
//     return FirebaseFirestore.instance.collection('tractors').doc(docId).get();
//   }).toList();
//
//   List<DocumentSnapshot> results = await Future.wait(futures);
//   return results.where((doc) => doc.exists).toList();
// }
//
// Future<List<String>> searchTractorsByPincode(String pincode) async {
//   String jsonString = await rootBundle.loadString('lib/data/pincode_data.json');
//   List<dynamic> pincodeList = json.decode(jsonString);
//
//   String? district;
//   String? state;
//
//   for (var entry in pincodeList) {
//     if (entry["Pincode"] == pincode) {
//       district = entry["District"];
//       state = entry["StateName"];
//       break;
//     }
//   }
//
//   if (state == null) {
//     print("Pincode not found. Searching by state...");
//     return searchTractorsByStateOnly(); // New function to handle state search
//   }
//
//   print("Searching tractors in District: $district, State: $state");
//
//   List<String> tractorIds = [];
//
//   if (district != null) {
//     QuerySnapshot districtQuery = await FirebaseFirestore.instance
//         .collection('tractors')
//         .where('location', isEqualTo: district)
//         .get();
//     tractorIds = districtQuery.docs.map((doc) => doc.id).toList();
//   }
//
//   if (tractorIds.isEmpty) {
//     print("No results found in district. Searching in state: $state");
//     QuerySnapshot stateQuery = await FirebaseFirestore.instance
//         .collection('tractors')
//         .where('state', isEqualTo: state)
//         .get();
//     tractorIds = stateQuery.docs.map((doc) => doc.id).toList();
//   }
//
//   return tractorIds;
// }
//
// Future<List<String>> searchTractorsByStateOnly() async {
//   QuerySnapshot stateQuery = await FirebaseFirestore.instance
//       .collection('tractors')
//       .where('state', isNotEqualTo: "")
//       .get();
//
//   return stateQuery.docs.map((doc) => doc.id).toList();
// }
// final TextEditingController searchController = TextEditingController();
// String searchQuery = '';
// String locationQuery = '';
//
// // Stream<QuerySnapshot> getTractorsStream() {
// //   if (searchQuery.isEmpty) {
// //     return FirebaseFirestore.instance.collection('tractors').snapshots();
// //   } else {
// //     return FirebaseFirestore.instance
// //         .collection('tractors')
// //         .where('name', isGreaterThanOrEqualTo: searchQuery)
// //         .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
// //         .snapshots();
// //   }
// // }
// // Stream<QuerySnapshot> getTractorsByLocationStream(String locationQuery) {
// //   if (locationQuery.isEmpty) {
// //     return FirebaseFirestore.instance.collection('tractors').snapshots();
// //   } else {
// //     return FirebaseFirestore.instance
// //         .collection('tractors')
// //         .where('state', isGreaterThanOrEqualTo: locationQuery)
// //         .where('state', isLessThanOrEqualTo: locationQuery + '\uf8ff')
// //         .snapshots();
// //   }
// //
// // }
// Stream<List<QueryDocumentSnapshot>> getTractorsStream({String searchQuery = '', String locationQuery = ''}) {
//   CollectionReference tractorsRef = FirebaseFirestore.instance.collection('tractors');
//
//   if (searchQuery.isEmpty && locationQuery.isEmpty) {
//     return tractorsRef.snapshots().map((snapshot) => snapshot.docs);
//   } else if (searchQuery.isNotEmpty && locationQuery.isEmpty) {
//     return tractorsRef
//         .where('name', isGreaterThanOrEqualTo: searchQuery)
//         .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
//         .snapshots()
//         .map((snapshot) => snapshot.docs);
//   } else if (locationQuery.isNotEmpty && searchQuery.isEmpty) {
//     return tractorsRef
//         .where('state', isGreaterThanOrEqualTo: locationQuery)
//         .where('state', isLessThanOrEqualTo: locationQuery + '\uf8ff')
//         .snapshots()
//         .map((snapshot) => snapshot.docs);
//   } else {
//     return tractorsRef.snapshots().map((snapshot) {
//       return snapshot.docs.where((doc) {
//         final brand = (doc['name'] ?? '').toString().toLowerCase();
//         final state = (doc['state'] ?? '').toString().toLowerCase();
//         return brand.contains(searchQuery.toLowerCase()) || state.contains(locationQuery.toLowerCase());
//       }).toList();
//     });
//   }
// }


class _searchState extends State<search> {
  // TextEditingController search = TextEditingController();
  // TextEditingController location = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? selectedBrand;
  String? selectedModel;
  String? selectedState;
  String? selectedCity;

  List<String> brands = [];
  List<String> models = [];
  List<String> states = [];
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    fetchUniqueBrands();
  }

  // Fetch unique brands from Firestore
  Future<void> fetchUniqueBrands() async {
    Set<String> uniqueBrands = {};
    QuerySnapshot querySnapshot = await _firestore.collection('tractors').get();

    for (var doc in querySnapshot.docs) {
      String? brand = doc['brand'];
      if (brand != null && brand.isNotEmpty) {
        uniqueBrands.add(brand);
      }
    }

    setState(() {
      brands = uniqueBrands.toList();
    });
  }

  // Fetch unique models for selected brand
  Future<void> fetchModels(String brand) async {
    Set<String> uniqueModels = {};
    QuerySnapshot querySnapshot = await _firestore
        .collection('tractors')
        .where('brand', isEqualTo: brand)
        .get();

    for (var doc in querySnapshot.docs) {
      String? model = doc['model'];
      if (model != null && model.isNotEmpty) {
        uniqueModels.add(model);
      }
    }

    setState(() {
      models = uniqueModels.toList();
      selectedModel = null;
    });
  }

  // Fetch unique states for selected brand & model
  Future<void> fetchStates(String brand, String model) async {
    Set<String> uniqueStates = {};
    QuerySnapshot querySnapshot = await _firestore
        .collection('tractors')
        .where('brand', isEqualTo: brand)
        .where('model', isEqualTo: model)
        .get();

    for (var doc in querySnapshot.docs) {
      String? state = doc['state'];
      if (state != null && state.isNotEmpty) {
        uniqueStates.add(state);
      }
    }

    setState(() {
      states = uniqueStates.toList();
      selectedState = null;
    });
  }

  // Fetch unique cities for selected brand, model & state
  Future<void> fetchCities(String brand, String model, String state) async {
    Set<String> uniqueCities = {};
    QuerySnapshot querySnapshot = await _firestore
        .collection('tractors')
        .where('brand', isEqualTo: brand)
        .where('model', isEqualTo: model)
        .where('state', isEqualTo: state)
        .get();

    for (var doc in querySnapshot.docs) {
      String? city = doc['location'];
      if (city != null && city.isNotEmpty) {
        uniqueCities.add(city);
      }
    }

    setState(() {
      cities = uniqueCities.toList();
      selectedCity = null;
    });
  }

  // Fetch tractors based on filters
  Stream<List<QueryDocumentSnapshot>> getFilteredTractors() {
    Query query = _firestore.collection('tractors');

    if (selectedBrand != null) {
      query = query.where('brand', isEqualTo: selectedBrand);
    }
    if (selectedModel != null) {
      query = query.where('model', isEqualTo: selectedModel);
    }
    if (selectedState != null) {
      query = query.where('state', isEqualTo: selectedState);
    }
    if (selectedCity != null) {
      query = query.where('location', isEqualTo: selectedCity);
    }

    return query.snapshots().map((snapshot) => snapshot.docs);
  }

  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isDropdownOpen = false;

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
                  GridViewWidget(controller: getFilteredTractors(),)
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
                  Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                      children: [
                  Row(
                  children: [
                  Expanded(
                  child: GestureDetector(
                      onTap: () {
                setState(() {
                isDropdownOpen = !isDropdownOpen; // Toggle animation state
                });
                },
                    child: DropDownSearchField<String>(
                      suggestionsCallback: (pattern) async {
                        return brands
                            .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                            .toList();
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: brandController,
                        decoration: InputDecoration(
                          hintText: "Brand",
                          hintStyle: GoogleFonts.anybody(),
                          prefixIcon: AnimatedRotation(
                            turns: isDropdownOpen ? 0.5 : 0, // Rotate 180° when open
                            duration: Duration(milliseconds: 300),
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                        ),
                      ),
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          selectedBrand = suggestion;
                          brandController.text = suggestion;
                          selectedModel = null;
                          selectedState = null;
                          selectedCity = null;
                          models.clear();
                          states.clear();
                          cities.clear();
                        });
                        fetchModels(suggestion);
                      },
                      displayAllSuggestionWhenTap: true,
                      isMultiSelectDropdown: false,
                    ),

                ),
              ),
                    Container(
                      width: 1.5, // Thickness of the divider
                      height: 30, // Height to match TextField height
                      color: Colors.grey, // Color of the divider
                      margin: EdgeInsets.symmetric(horizontal: 12), // Space around divider
                    ),
                    Expanded(
                      child: DropDownSearchField<String>(
                        suggestionsCallback: (pattern) async {
                          return models
                              .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                              .toList();
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          controller:modelController,
                          decoration: InputDecoration(
                            prefixIcon:Icon(Icons.keyboard_arrow_down) ,
                            hintText: 'Model',
                            hintStyle: GoogleFonts.anybody(),
                          )
                      
                        ),
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          setState(() {
                            selectedModel = suggestion;
                            modelController.text = suggestion;
                            selectedState = null;
                            selectedCity = null;
                            states.clear();
                            cities.clear();
                          });
                          fetchStates(brandController.text!,suggestion);
                        },
                        displayAllSuggestionWhenTap: true,
                        isMultiSelectDropdown: false,
                      ),
                    ),
                  ],
                ),
                  const Divider(color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropDownSearchField<String>(
                          suggestionsCallback: (pattern) async {
                            return states
                                .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                                .toList();
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            controller:stateController,
                            decoration: InputDecoration(
                              hintText: "State",
                              hintStyle: GoogleFonts.anybody(),
                              prefixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                            )
                        
                          ),
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              selectedState = suggestion;
                              stateController.text = suggestion;
                              selectedCity = null;
                              cities.clear();
                            });
                            fetchCities(brandController.text!,modelController.text!,suggestion);
                          },
                          displayAllSuggestionWhenTap: true,
                          isMultiSelectDropdown: false,
                        ),
                      ),

                      Container(
                        width: 1.5, // Thickness of the divider
                        height: 30, // Height to match TextField height
                        color: Colors.grey, // Color of the divider
                        margin: EdgeInsets.symmetric(horizontal: 12), // Space around divider
                      ),
                      Expanded(
                        child: DropDownSearchField<String>(
                          suggestionsCallback: (pattern) async {
                            return cities
                                .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                                .toList();
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            controller:cityController,
                            decoration: InputDecoration(
                              hintText: 'City',
                              hintStyle: GoogleFonts.anybody(),
                              prefixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                            )
                        
                          ),
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              selectedCity = suggestion;
                              cityController.text = suggestion;
                              selectedCity = null;
                              cities.clear();
                            });
                          },
                          displayAllSuggestionWhenTap: true,
                          isMultiSelectDropdown: false,
                        ),
                      ),
                    ],
                  ),
                  ],
                        ),
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
  // List of document IDs to fetch.
  final Stream<List<QueryDocumentSnapshot>> controller;

  GridViewWidget({super.key, required this.controller, });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: StreamBuilder<List<QueryDocumentSnapshot>>(
        stream: controller, // Fetch tractors based on document IDs
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          var tractors = snapshot.data!;

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
              var docSnapshot = snapshot.data![index];
              String docId =docSnapshot.id;
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
                            docId: docId,
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
                            safetyfeature: tractor['safetyFeatures'] ?? "",
                            warrenty: tractor['warranty'] ?? "",
                            color: tractor['color'] ?? "",
                            accessories: tractor['accessories'] ?? "",
                            rpm: tractor['rpm'] ?? "",
                            ptodirection: '' ?? "",
                            battery: tractor['battery'] ?? "",
                            cylinder: tractor['noOfCylinders'] ?? "",
                            gearbox: tractor['gearBox'] ?? "",
                            torque: '' ?? "",
                            fronttyre: tractor['frontTyreSize'],
                            clutch: tractor['clutch']?? "",
                            pincode: tractor['pincode']?? " ",
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



