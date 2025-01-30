import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loanenquire extends StatefulWidget {
  const Loanenquire({super.key});

  @override
  State<Loanenquire> createState() => _LoanenquireState();
}
final TextEditingController _nameController = TextEditingController();
final TextEditingController _mobileNumberController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _amountController = TextEditingController();
final TextEditingController _vehicleController = TextEditingController();


class _LoanenquireState extends State<Loanenquire> {
  final TextEditingController _nameloanController = TextEditingController();
  final TextEditingController _mobileloanNumberController =
      TextEditingController();
  final TextEditingController _emailloanController = TextEditingController();
  final TextEditingController _amountloanController = TextEditingController();
  final TextEditingController _vehicleloanController = TextEditingController();

  @override
  void dispose() {
    _nameloanController.dispose();
    _mobileloanNumberController.dispose();
    _emailloanController.dispose();
    _amountloanController.dispose();
    _vehicleloanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Vector3.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 39),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 60),
                        Text(
                          'Loan Enquiry',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/rupee.png',
                          width: size.width * 0.8,
                          height: size.height * 0.8,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                      "Name", _nameloanController, TextInputType.text),
                  const SizedBox(height: 16.0),
                  _buildTextField("Mobile Number", _mobileloanNumberController,
                      TextInputType.phone),
                  const SizedBox(height: 16.0),
                  _buildTextField("Email-ID (Optional)", _emailloanController,
                      TextInputType.emailAddress),
                  const SizedBox(height: 16.0),
                  _buildTextField("Enter Amount", _amountloanController,
                      TextInputType.number),
                  const SizedBox(height: 16.0),
                  _buildTextField("Vehicle Details", _vehicleloanController,
                      TextInputType.text),
                  const SizedBox(height: 20),

                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                        "By proceeding, you agree to Tractor24 ",
                           style: GoogleFonts.anybody(fontSize: 14,fontWeight: FontWeight.w400, color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: "Terms of  Service",
                            style: GoogleFonts.anybody(
                            fontSize: 14,fontWeight: FontWeight.w400, color: Color(0xFF003B8F)),
                      )
                    ]
                  )),
                  // Container(
                  //  // mainAxisAlignment: MainAxisAlignment.start,
                  //   child:
                  //     // Text(
                  //     //   "By proceeding, you agree to Tractor24 ",
                  //     //   style: GoogleFonts.anybody(
                  //     //       fontSize: 14,fontWeight: FontWeight.w400, color: Colors.grey[600]),
                  //     // ),
                  //     Text(
                  //       "Terms of Service",
                  //       style: GoogleFonts.anybody(
                  //           fontSize: 14,fontWeight: FontWeight.w400, color: Color(0xFF003B8F)),
                  //     ),
                  //
                  //
                  // ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement send inquiry logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003B8F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Send Enquiry',
                        style: GoogleFonts.anybody(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextField(
    String label, TextEditingController controller, TextInputType inputType) {
  return TextField(
    controller: controller,
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.anybody(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color:Color.fromRGBO(124, 139, 160, 1.0),
      ),
      // floatingLabelBehavior: FloatingLabelBehavior.auto,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(2.0),
      //   //borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8.0),
      //   borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
      // ),
      // contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8.0),
      //   borderSide: const BorderSide(color: Colors.black, width: 2.0),
      // ),
    ),
  );
}
