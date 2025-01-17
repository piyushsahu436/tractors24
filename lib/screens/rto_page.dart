import 'package:flutter/material.dart';


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
        appBar: AppBar(
          title:
          Text(
            'Enter Vehicle Details',

            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                ..._buildTextFields(),
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
