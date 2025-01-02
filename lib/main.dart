import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tractors24/buyer_page.dart';
import 'package:tractors24/spalshscreen.dart';

import 'login_page.dart'; // Your Login Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractor',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary swatch to blue
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue, // Use blue as the primary color
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Tractors'), // Set SplashScreen as the home screen
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration for animation
    );

    // Start the animation and navigate on completion
    _controller.forward().whenComplete(() {
      // Navigate to the SplashScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Rotate the image using RotationTransition
            RotationTransition(
              turns: _controller, // Connect the animation controller
              child: Image.asset(
                "assets/tractor.png",
                height: 150, // Adjust height as needed
                width: 150,  // Adjust width as needed
                fit: BoxFit.cover, // Ensure the image fits well
              ),
            ),
            const SizedBox(height: 20), // Adds space between the image and text
            const Text(
              'Drive Now',
              style: TextStyle(
                fontSize: 50, // Font size set to 50
                fontWeight: FontWeight.bold, // Bold font
                color: Colors.blue, // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class VehicleDetailsForm extends StatefulWidget {
  @override
  _VehicleDetailsFormState createState() => _VehicleDetailsFormState();
}
class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController modelYearController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController _registrationNoController = TextEditingController();
  final TextEditingController _registrationDateController = TextEditingController();
  final TextEditingController _chassisNoController = TextEditingController();
  final TextEditingController _engineNoController = TextEditingController();
  final TextEditingController _vehicleClassController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _makerModelController = TextEditingController();
  final TextEditingController _fitnessUptoController = TextEditingController();
  final TextEditingController _insuranceUptoController = TextEditingController();
  final TextEditingController _fuelNormsController = TextEditingController();
  final TextEditingController _financierNameController = TextEditingController();
  final TextEditingController _pucUptoController = TextEditingController();
  final TextEditingController _roadTaxPaidUptoController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _seatCapacityController = TextEditingController();
  final TextEditingController _unloadWeightController = TextEditingController();
  final TextEditingController _bodyTypeDescController = TextEditingController();
  final TextEditingController _manufactureMonthYearController = TextEditingController();
  final TextEditingController _rcStatusController = TextEditingController();
  final TextEditingController _ownershipController = TextEditingController();
  final TextEditingController _ownershipDescController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _submitForm() {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    // Simulate a save operation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vehicle Details Submitted Successfully')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter Vehicle Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ..._buildTextFields(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextFields() {
    final fields = [
      {'label': 'Vehicle Name', 'controller': vehicleNameController, 'icon': Icons.directions_car},
      {'label': 'Registration Number', 'controller': registrationNumberController, 'icon': Icons.confirmation_number},
      {'label': 'Model Year', 'controller': modelYearController, 'icon': Icons.calendar_today},
      {'label': 'Owner Name', 'controller': ownerNameController, 'icon': Icons.person},
      {'label': 'Registration No.', 'controller': _registrationNoController, 'icon': Icons.article},
      {'label': 'Registration Date', 'controller': _registrationDateController, 'icon': Icons.date_range},
      {'label': 'Chassis No.', 'controller': _chassisNoController, 'icon': Icons.settings},
      {'label': 'Engine No.', 'controller': _engineNoController, 'icon': Icons.engineering},
      {'label': 'Vehicle Class', 'controller': _vehicleClassController, 'icon': Icons.category},
      {'label': 'Fuel Type', 'controller': _fuelTypeController, 'icon': Icons.local_gas_station},
      {'label': 'Maker Model', 'controller': _makerModelController, 'icon': Icons.build},
      {'label': 'Fitness Upto', 'controller': _fitnessUptoController, 'icon': Icons.access_time},
      {'label': 'Insurance Upto', 'controller': _insuranceUptoController, 'icon': Icons.verified_user},
      {'label': 'Fuel Norms', 'controller': _fuelNormsController, 'icon': Icons.info},
      {'label': 'Financier Name', 'controller': _financierNameController, 'icon': Icons.account_balance},
      {'label': 'PUC Upto', 'controller': _pucUptoController, 'icon': Icons.check_circle},
      {'label': 'Road Tax Paid Upto', 'controller': _roadTaxPaidUptoController, 'icon': Icons.attach_money},
      {'label': 'Vehicle Color', 'controller': _vehicleColorController, 'icon': Icons.color_lens},
      {'label': 'Seat Capacity', 'controller': _seatCapacityController, 'icon': Icons.event_seat},
      {'label': 'Unload Weight', 'controller': _unloadWeightController, 'icon': Icons.scale},
      {'label': 'Body Type Description', 'controller': _bodyTypeDescController, 'icon': Icons.description},
      {'label': 'Manufacture Month/Year', 'controller': _manufactureMonthYearController, 'icon': Icons.date_range},
      {'label': 'RC Status', 'controller': _rcStatusController, 'icon': Icons.check},
      {'label': 'Ownership', 'controller': _ownershipController, 'icon': Icons.group},
      {'label': 'Ownership Description', 'controller': _ownershipDescController, 'icon': Icons.notes},
    ];

    return fields.map((field) {
      return Column(
        children: [
          TextFormField(
            controller: field['controller'] as TextEditingController,
            decoration: InputDecoration(
              labelText: field['label'] as String,
              prefixIcon: Icon(field['icon'] as IconData),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) => (value?.isEmpty ?? true) ? 'Please enter ${field['label']}' : null,
          ),
          const SizedBox(height: 16),
        ],
      );
    }).toList();
  }
}
