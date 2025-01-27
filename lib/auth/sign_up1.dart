import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final TextEditingController pincodeController = TextEditingController();

class _SignUp1 extends State<SignUp1> {
  bool isTermsAccepted = false;
  bool isLoading = false;

  void _login(BuildContext context) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.04,
                width: size.width * 10,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Vector_signup.png'),
                      fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text('Sign Up',
                          style: GoogleFonts.anybody(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF003B8F),
                          )),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "assets/images/_Facebook.png",
                                    ),
                                    Text(
                                      'Facebook',
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
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300, // Line color
                            thickness: 1, // Line thickness
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Or',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400)),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300, // Line color
                            thickness: 1, // Line thickness
                          ),
                        ),
                      ],
                    ),
                    Form_field(
                        hintText: "Name",
                        controller: nameController,
                        prefixtext: ""),
                    SizedBox(height: size.height * 0.008),
                    Form_field(
                        hintText: "Email/Phone Number",
                        controller: emailController,
                        prefixtext: ""),
                    SizedBox(height: size.height * 0.0001),
                    Form_field(
                        hintText: "Phone Number",
                        controller: phoneController,
                        prefixtext: ""),
                    SizedBox(height: size.height * 0.001),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.anybody(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(124, 139, 160, 1.0)),
                        suffixIcon: Icon(Icons.visibility_off,
                            color: Color(
                                0xFF61677D)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),//have to make this icon functional
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: GoogleFonts.anybody(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(124, 139, 160, 1.0)),
                        suffixIcon: Icon(Icons.visibility_off,
                            color: Color(
                                0xFF61677D)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),//have to make this icon functional
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                    ),
                    SizedBox(height: size.height * 0.001),
                    Form_field(
                        hintText: "Pin Code",
                        controller: pincodeController,
                        prefixtext: ""),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: isTermsAccepted,
                            onChanged: (bool? value) {
                              setState(() {
                                isTermsAccepted = value ?? false;
                              });
                            },
                            side: BorderSide(
                              color: Color(0xFF003B8F),
                              width: 1.0,
                            ),
                            activeColor: Color(
                                0xFF003B8F), // Optional: Color when the checkbox is checked
                            checkColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                    text: "I'm agree to the ",
                                    style: GoogleFonts.anybody(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                  text: "Term's of Service",
                                  style: GoogleFonts.anybody(
                                    color: Color(0xFF003B8F),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                    text: " and ",
                                    style: GoogleFonts.anybody(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: GoogleFonts.anybody(
                                    color: Color(0xFF003B8F),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:
                            isTermsAccepted ? () => _login(context) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF003B8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Create Account',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.001),

                    // Sign up text and button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Don't have account? ",
                            style: GoogleFonts.anybody(
                                fontWeight: FontWeight.w400),
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
            ],
          ),
        ),
      ),
    );
  }
}
