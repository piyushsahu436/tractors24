import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_password.dart';
import 'package:tractors24/auth/OTPPage.dart';
import 'package:tractors24/auth/sign_up1.dart';
import 'package:tractors24/screens/otpScreen.dart';

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
                  style: GoogleFonts.anybody(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003B8F),
                  )),
            ),

            SizedBox(height: size.height * 0.01),

            // Mobile number input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ]),
                child: TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Mobile No.',
                    prefixText: '+91 ',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // Agreement text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.anybody(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(text: 'By Logging in, you agree with '),
                    TextSpan(
                      text: 'User Agreement',
                      style: GoogleFonts.anybody(
                        color: Color(0xFF003B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(text: ', '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.anybody(
                        color: Color(0xFF003B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
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
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationid, int? resendtoken) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>otpScreen(verificationid: verificationid,)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: phoneController.text.toString());
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
                  style: GoogleFonts.anybody(
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
                  style: GoogleFonts.anybody(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            SizedBox(height: size.height * 0.01),

            Text(
              'Or',
              style: GoogleFonts.anybody(),
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
                                style: GoogleFonts.anybody(
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
                                style: GoogleFonts.anybody(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Don't have account? ",
                    style: GoogleFonts.anybody(fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp1(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.anybody(
                        color: Color(0xFF003B8F),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
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

class Form_field extends StatelessWidget {
  Form_field(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.prefixtext});
  final String hintText;
  final TextEditingController controller;
  final String prefixtext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.anybody(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color.fromRGBO(124, 139, 160, 1.0)),
            prefixText: prefixtext,

            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class heading extends StatelessWidget {
  const heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
         decoration: BoxDecoration(
           color: Color(0xFF003B8F),
           borderRadius: BorderRadius.circular(12),
         ),
          child: ImageIcon(AssetImage("assets/images/arrow.png")),
        )
       // Text("data")
    ],
    );
  }
}
