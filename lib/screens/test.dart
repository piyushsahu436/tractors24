import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:rive/rive.dart';
import 'package:searchfield/searchfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/LanguagePage.dart';
import 'package:tractors24/screens/search.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class FullScreenAnimation extends StatefulWidget {
  final Widget page;
  final String image;

  const FullScreenAnimation({super.key, required this.page, required this.image});

  @override
  _FullScreenAnimationState createState() => _FullScreenAnimationState();
}

class _FullScreenAnimationState extends State<FullScreenAnimation> {
  StateMachineController? _stateMachineController;
  SMITrigger? _trigger;


  void _onRiveInit(Artboard artboard) {
    print('✅ Artboard loaded successfully');

    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    final SMIInput<dynamic>? input = controller?.findInput<dynamic>('Trigger 1');
    if (input != null && input is SMITrigger) {
      _trigger = input;  // Assigning the correct type
      print("✅ Trigger assigned successfully");
      Future.delayed(Duration(milliseconds: 100), () {
        _trigger!.fire();
      });
    } else {
      print("❌ Found input but it's not an SMITrigger: $input");
    }



    if (controller == null) {
      print('❌ State Machine Controller not found');
      return;
    }

    artboard.addController(controller);

    // Print all available inputs
    for (var input in controller.inputs) {
      print("🔹 Input Name: '${input.name}', Type: ${input.runtimeType}");
    }

    _trigger = controller.findInput<SMITrigger>('Trigger 1') as SMITrigger?;

    if (_trigger != null) {
      print("✅ Trigger found: $_trigger");
      Future.delayed(Duration(milliseconds: 100), () {
        _trigger!.fire();
      });
    } else {
      print("❌ Trigger still null");
    }

  }


  @override
  void initState() {
    super.initState();

    // Navigate after animation delay
    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 650), // Smooth transition
            pageBuilder: (context, animation, secondaryAnimation) => widget.page,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: RiveAnimation.asset(
              'assets/animations/${widget.image}',
              fit: BoxFit.cover,
              onInit: _onRiveInit,
            ),
          ),
        ],
      ),
    );
  }
}



class anime extends StatefulWidget {
  const anime({super.key, required this.image, required this.seconds, required this.nextClass});

  final String image;
  final int seconds;
  final Widget nextClass;

  @override
  State<anime> createState() => _animeState();
}
late RiveAnimationController __controller;


class _animeState extends State<anime> {

  @override
  void initState() {
    super.initState();
    __controller = SimpleAnimation('Timeline 1');// Check animation name in Rive file

    Future.delayed( Duration(seconds: widget.seconds), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  widget.nextClass),
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

          RiveAnimation.asset("assets/animations/${widget.image}", fit: BoxFit.cover,controllers: [__controller],),
        ], // Stack
      ),
    );
  }
}

class TractorFilterPage extends StatefulWidget {
  const TractorFilterPage({super.key});

  @override
  _TractorFilterPageState createState() => _TractorFilterPageState();
}

class _TractorFilterPageState extends State<TractorFilterPage> {
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
  Future<QuerySnapshot> getFilteredTractors() async {
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

    return query.get();
  }
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tractor Filter")),
      body: Column(
        children: [
          // Brand Dropdown (Editable)
          DropDownSearchField<String>(
            suggestionsCallback: (pattern) async {
              return brands
                  .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller:brandController,

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

          // DropdownButtonFormField<String>(
          //   decoration: InputDecoration(
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Image.asset(
          //         'assets/icons/calendar.png',
          //         width: 24,
          //         height: 24,
          //       ),
          //     ),
          //     hintText: 'Brand',
          //     hintStyle: GoogleFonts.roboto(
          //         fontWeight: FontWeight.w400,
          //         fontSize: 16,
          //         color: const Color.fromRGBO(124, 139, 160, 1.0)),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: BorderSide(color: Colors.grey.shade300),
          //     ),
          //   ),
          //   value: selectedBrand,
          //   hint: Text("Select Brand"),
          //   isExpanded: true,
          //   items: brands.map((String year) {
          //     return DropdownMenuItem<String>(
          //       value: year,
          //       child: Text(year),
          //     );
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedBrand = newValue;
          //       selectedModel = null;
          //       selectedState = null;
          //       selectedCity = null;
          //       models.clear();
          //       states.clear();
          //       cities.clear();
          //     });
          //     if (newValue != null) fetchModels(newValue);
          //   },
          // ),
          // DropdownSearch<String>(
          //   items: brands,
          //   popupProps: PopupProps.menu(
          //     showSearchBox: true,
          //   ),
          //   dropdownBuilder: (context, selectedItem) => Text(
          //     selectedItem ?? "Select Brand",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedBrand = newValue;
          //       selectedModel = null;
          //       selectedState = null;
          //       selectedCity = null;
          //       models.clear();
          //       states.clear();
          //       cities.clear();
          //     });
          //     if (newValue != null) fetchModels(newValue);
          //   },
          // ),

          SizedBox(height: 10),

          // Model Dropdown
          DropDownSearchField<String>(
            suggestionsCallback: (pattern) async {
              return models
                  .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller:modelController,

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
          // DropdownButtonFormField<String>(
          //   decoration: InputDecoration(
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Image.asset(
          //         'assets/icons/calendar.png',
          //         width: 24,
          //         height: 24,
          //       ),
          //     ),
          //     hintText: 'Registration Year',
          //     hintStyle: GoogleFonts.roboto(
          //         fontWeight: FontWeight.w400,
          //         fontSize: 16,
          //         color: const Color.fromRGBO(124, 139, 160, 1.0)),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: BorderSide(color: Colors.grey.shade300),
          //     ),
          //   ),
          //   value: selectedModel,
          //   hint: Text("Select Year"),
          //   isExpanded: true,
          //   items: models.map((String year) {
          //     return DropdownMenuItem<String>(
          //       value: year,
          //       child: Text(year),
          //     );
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedModel = newValue;
          //       selectedState = null;
          //       selectedCity = null;
          //       states.clear();
          //       cities.clear();
          //     });
          //     if (newValue != null) fetchStates(selectedBrand!, newValue);
          //   },
          // ),
          // DropdownSearch<String>(
          //   items: models,
          //   enabled: selectedBrand != null,
          //   popupProps: PopupProps.menu(
          //     showSearchBox: true,
          //   ),
          //   dropdownBuilder: (context, selectedItem) => Text(
          //     selectedItem ?? "Select Model",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedModel = newValue;
          //       selectedState = null;
          //       selectedCity = null;
          //       states.clear();
          //       cities.clear();
          //     });
          //     if (newValue != null) fetchStates(selectedBrand!, newValue);
          //   },
          // ),

          SizedBox(height: 10),

          // State Dropdown
          DropDownSearchField<String>(
            suggestionsCallback: (pattern) async {
              return states
                  .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller:stateController,

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
          // DropdownButtonFormField<String>(
          //   decoration: InputDecoration(
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Image.asset(
          //         'assets/icons/calendar.png',
          //         width: 24,
          //         height: 24,
          //       ),
          //     ),
          //     hintText: 'Registration Year',
          //     hintStyle: GoogleFonts.roboto(
          //         fontWeight: FontWeight.w400,
          //         fontSize: 16,
          //         color: const Color.fromRGBO(124, 139, 160, 1.0)),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: BorderSide(color: Colors.grey.shade300),
          //     ),
          //   ),
          //   value: selectedState,
          //   hint: Text("Select Year"),
          //   isExpanded: true,
          //   items: states.map((String year) {
          //     return DropdownMenuItem<String>(
          //       value: year,
          //       child: Text(year),
          //     );
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedState = newValue;
          //       selectedCity = null;
          //       cities.clear();
          //     });
          //     if (newValue != null)
          //       fetchCities(selectedBrand!, selectedModel!, newValue);
          //   },
          // ),
          // DropdownSearch<String>(
          //   items: states,
          //   enabled: selectedModel != null,
          //   popupProps: PopupProps.menu(
          //     showSearchBox: true,
          //   ),
          //   dropdownBuilder: (context, selectedItem) => Text(
          //     selectedItem ?? "Select State",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedState = newValue;
          //       selectedCity = null;
          //       cities.clear();
          //     });
          //     if (newValue != null)
          //       fetchCities(selectedBrand!, selectedModel!, newValue);
          //   },
          // ),

          SizedBox(height: 10),

          // City Dropdown
          DropDownSearchField<String>(
            suggestionsCallback: (pattern) async {
              return cities
                  .where((brand) => brand.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller:cityController,

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
          // DropdownButtonFormField<String>(
          //   decoration: InputDecoration(
          //     prefixIcon: Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Image.asset(
          //         'assets/icons/calendar.png',
          //         width: 24,
          //         height: 24,
          //       ),
          //     ),
          //     hintText: 'Registration Year',
          //     hintStyle: GoogleFonts.roboto(
          //         fontWeight: FontWeight.w400,
          //         fontSize: 16,
          //         color: const Color.fromRGBO(124, 139, 160, 1.0)),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8),
          //       borderSide: BorderSide(color: Colors.grey.shade300),
          //     ),
          //   ),
          //   value: selectedCity,
          //   hint: Text("Select Year"),
          //   isExpanded: true,
          //   items: cities.map((String year) {
          //     return DropdownMenuItem<String>(
          //       value: year,
          //       child: Text(year),
          //     );
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedCity = newValue;
          //     });
          //   },
          // ),
          // DropdownSearch<String>(
          //   items: cities,
          //   enabled: selectedState != null,
          //   popupProps: PopupProps.menu(
          //     showSearchBox: true,
          //   ),
          //   dropdownBuilder: (context, selectedItem) => Text(
          //     selectedItem ?? "Select City",
          //     style: TextStyle(fontSize: 16),
          //   ),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedCity = newValue;
          //     });
          //   },
          // ),


          const SizedBox(height: 20),
          // Results Display
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: getFilteredTractors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No tractors found"));
                }

                List<QueryDocumentSnapshot> tractors = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: tractors.length,
                  itemBuilder: (context, index) {
                    var tractor = tractors[index];
                    return ListTile(
                      title: Text(tractor['name']),
                      subtitle: Text(
                          "Model: ${tractor['model']} - Location: ${tractor['location']}"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}