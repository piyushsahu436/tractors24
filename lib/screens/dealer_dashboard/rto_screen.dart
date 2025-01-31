import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RtoManagementApp extends StatelessWidget {
  const RtoManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(

          body: const RtoForm(),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class RtoForm extends StatelessWidget {
  const RtoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text('RTO Management',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey[700]))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Enter the registration number to fetch vehicle details or manually fill in the required fields.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildFormField("Registration No*", "Registration No*"),
          const SizedBox(width: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0D5CA2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Fetch Details', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(height: 10),
          buildFormField("Registration Date*", "dd-mm-yy", Icons.calendar_today),
          buildFormField("Owner Name*", "Enter the Registration No"),
          buildFormField("Vehicle Class*", "Enter the Vehicle Class"),
          buildFormField("Fuel Type*", "Enter Fuel Type"),
          buildFormField("Maker Model*", "Enter Maker Model*"),
          buildFormField("Fitness Upto*", "dd-mm-yy"),
          buildFormField("Insurance Upto*", "dd-mm-yy"),
          buildFormField("Fuel Norms*", "Enter Fuel Norms*"),
          buildFormField("Financier Name*", "Enter Financier Name*"),
          buildFormField("PUC Upto*", "dd-mm-yy"),
          buildFormField("Road Tax Paid Upto*", "dd-mm-yy"),
          buildFormField("Vehicle Color*", "Enter Vehicle Color*"),
          buildFormField("Seat Capacity*", "Enter Seat Capacity*"),
          buildFormField("Unload Weight*", "Enter Unload Weight*"),
          buildFormField("Body Type Description*", "Enter Body Type Description*"),
          buildFormField("Manufacture Month/Year*", "Enter Manufacture Month/Year*"),
          buildFormField("RC Status*", "Enter RC Status*"),
          buildFormField("Ownership Description*", "Enter Ownership Description*"),
          buildFormField("RTO Office*", "Enter RTO Office*"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor:Color(0xFF0D5CA2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 15),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Add RTO Record', style: TextStyle(fontSize: 18 , color: Colors.white,),),
          ),
        ],
      ),
    );
  }

  Widget buildFormField(String label, String hint, [IconData? icon]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 18)),
        CustomTextField(label: hint, hintText: hint, icon: icon),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? icon;

  const CustomTextField({Key? key, required this.label, this.hintText, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: TextField(
          decoration: InputDecoration(

            hintText: label,
            hintStyle: TextStyle(color: Colors.grey[400]),
            suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}