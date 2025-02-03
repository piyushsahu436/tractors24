import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';

class Loanenquire extends StatefulWidget {
  const Loanenquire({super.key});

  @override
  State<Loanenquire> createState() => _LoanenquireState();
}

class _LoanenquireState extends State<Loanenquire> {
  final TextEditingController _nameloan = TextEditingController();
  final TextEditingController _mobilenumberloan = TextEditingController();
  final TextEditingController _emailloan = TextEditingController();
  final TextEditingController _amountloan = TextEditingController();
  final TextEditingController _vehicleloan = TextEditingController();

  @override
  void dispose() {
    _nameloan.dispose();
    _mobilenumberloan.dispose();
    _emailloan.dispose();
    _amountloan.dispose();
    _vehicleloan.dispose();
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
                  Form_field(
                      hintText: 'Name', controller: _nameloan, prefixtext: ""),
                  const SizedBox(height: 8),
                  Form_field(
                      hintText: 'Mobile Number',
                      controller: _mobilenumberloan,
                      prefixtext: ''),
                  const SizedBox(height: 8),
                  Form_field(
                      hintText: 'Email-ID (Optional)',
                      controller: _emailloan,
                      prefixtext: ''),
                  const SizedBox(height: 8),
                  Form_field(
                      hintText: 'Enter Amount',
                      controller: _amountloan,
                      prefixtext: ''),
                  const SizedBox(height: 8),
                  Form_field(
                      hintText: 'Vehicle Details',
                      controller: _vehicleloan,
                      prefixtext: ''),
                  const SizedBox(height: 20),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: " By proceeding, you agree to Tractor24 ",
                      style: GoogleFonts.anybody(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                    ),
                    TextSpan(
                      text: "Terms of Service",
                      style: GoogleFonts.anybody(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF003B8F)),
                    )
                  ])),
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
