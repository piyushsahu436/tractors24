import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_password.dart';
import 'package:tractors24/auth/otpScreen.dart';
import 'package:tractors24/auth/sign_up1.dart';
import 'package:tractors24/screens/policies_screen.dart';
import 'package:tractors24/screens/test.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Making a controller for mobile number input
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top wavy container
            Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Vector4.png'),
                      fit: BoxFit.fill),
                ),
                child: Image(image: AssetImage("assets/images/img.png"))),

            SizedBox(height: size.height * 0.01),

            // Logo image in circle
            Container(
              padding: EdgeInsets.all(0.1),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/Wave.png')),
              ),
              height: size.width * 0.3,
              width: size.width * 0.3,
            ),

            // SizedBox(
            //   height: size.height * 0.01,
            // ),

            Padding(
              padding: const EdgeInsets.all(0),
              child: Text('Login',
                  style: GoogleFonts.roboto(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003B8F),
                  )),
            ),

            SizedBox(height: size.height * 0.01),

            // Mobile number input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form_field(
                hintText: '    Mobile No.',
                controller: mobileController,
                prefixtext: '+91',
                validator: (String? value) {},
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // Agreement text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(text: 'By Logging in, you agree with '),
                    TextSpan(
                      text: 'User Agreement',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF003B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(text: ', '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF003B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PoliciesScreen()));
                        }
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Send OTP button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationid, int? resendtoken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => otpScreen(
                                      verificationid: verificationid,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: mobileController.text.toString());

                  // OTP functionality will be added later
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003B8F),
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Send OTP',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.01),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login2(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: BorderSide(
                      color: Color(0xFF003B8F),
                      width: size.width * 0.003,
                    )),
                child: Text(
                  'Login with Password',
                  style: GoogleFonts.roboto(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.01),

            Text(
              'Or',
              style: GoogleFonts.roboto(),
            ),

            SizedBox(height: size.height * 0.01),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          // Facebook login will be added later
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("assets/images/_Facebook.png"),
                              Text(
                                '  Facebook',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF61677D)),
                              )
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Expanded(
                    child: Container(
                      height: size.height * 0.06,
                      child: ElevatedButton(
                          onPressed: () {
                            // Google login will be added later
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/_Google.png"),
                              Text(
                                '  Google',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF61677D)),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // Sign up text and button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  RichText(
                    text: TextSpan(
                      text: "Do you have an account? ",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black, // Ensure text color is set
                      ),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF003B8F),
                            fontWeight: FontWeight.w400,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp1(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
}

class Form_field extends StatefulWidget {
  const Form_field({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixtext,
    required this.validator,
  });

  final String hintText;
  final TextEditingController controller;
  final String prefixtext;
  final FormFieldValidator<String> validator;

  @override
  _Form_fieldState createState() => _Form_fieldState();
}

class _Form_fieldState extends State<Form_field> {
  String? errorText;
  late FocusNode _focusNode;
  bool _showError = false; // Track when to show the error

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Remove error when the field is tapped (focused)
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showError = false; // Hide the error message
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void validateField() {
    final result = widget.validator(widget.controller.text);
    setState(() {
      errorText = result;
      _showError = result != null; // Show error only if validation fails
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
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
        child: TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color.fromRGBO(124, 139, 160, 1.0),
            ),
            prefixText: widget.prefixtext,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            border: InputBorder.none,
            errorText: _showError
                ? errorText
                : null, // Show error only when login is pressed
          ),
        ),
      ),
    );
  }
}
