import 'package:flutter/material.dart';

class ContactSellerScreen extends StatefulWidget {
  const ContactSellerScreen({super.key});

  @override
  _ContactSellerScreenState createState() => _ContactSellerScreenState();
}

class _ContactSellerScreenState extends State<ContactSellerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Seller"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", _nameController, TextInputType.text),
            const SizedBox(height: 16.0),
            _buildTextField(
                "Mobile Number", _mobileNumberController, TextInputType.phone),
            const SizedBox(height: 16.0),
            _buildTextField("Email-ID (Optional)", _emailController,
                TextInputType.emailAddress),
            const SizedBox(height: 16.0),
            _buildTextField(
                "Pincode", _pincodeController, TextInputType.number),
            const Spacer(),
            Column(
              children: [
                SizedBox(width: size.width*0.5,
                  height: size.height*0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Send Interest",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By proceeding, you agree to Tractor24 ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "Terms of Service",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildTextField(String label, TextEditingController controller,
    TextInputType inputType) {
  return TextField(
    controller: controller,
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      enabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.black, width: 2.0),
      ),
    ),
  );
}