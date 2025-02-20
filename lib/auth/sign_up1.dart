import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/auth/login_password.dart';
import 'package:tractors24/screens/policies_screen.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1();
}

class _SignUp1 extends State<SignUp1> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userType = 'Customer';
  bool isLoading = false;
  bool isCustomerSelected = true;
  bool isTermsAccepted = false;
  String? termsError;


  Future<void> _signUp() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'userType': userType,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Successful')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login2()));
    } on FirebaseAuthException catch (e) {
      _showError('Sign up failed: ${e.message}');
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.04,
                  width: size.width * 10,
                  decoration: const BoxDecoration(
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
                        padding: const EdgeInsets.all(0.1),
                        decoration: const BoxDecoration(
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
                            style: GoogleFonts.roboto(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF003B8F),
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
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF61677D)),
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
                                            color: const Color(0xFF61677D)),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300, // Line color
                                thickness: 1, // Line thickness
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "I`m a",
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCustomerSelected = true;
                                  userType = 'Customer';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                decoration: BoxDecoration(
                                  color: isCustomerSelected
                                      ? const Color(0xFF003B8F)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xFF003B8F), width: 2),
                                ),
                                child: Text(
                                  "Customer",
                                  style: GoogleFonts.poppins(
                                    color: isCustomerSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  userType = 'Dealer';
                                  isCustomerSelected = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                decoration: BoxDecoration(
                                  color: !isCustomerSelected
                                      ? const Color(0xFF003B8F)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xFF003B8F), width: 2),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Dealer",
                                          style: GoogleFonts.poppins(
                                            color: !isCustomerSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.01),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Soft shadow
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(2, 4), // Slight bottom shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color.fromRGBO(124, 139, 160, 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                return 'Enter a valid name (letters only)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.001),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Soft shadow
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(2, 4), // Slight bottom shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color.fromRGBO(124, 139, 160, 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.0001),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Soft shadow
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(2, 4), // Slight bottom shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color.fromRGBO(124, 139, 160, 1.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.001),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // Soft shadow
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset:
                                    const Offset(2, 4), // Slight bottom shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: const Color.fromRGBO(124, 139, 160, 1.0)),
                              suffixIcon: const Icon(Icons.visibility_off, color: Color(0xFF61677D)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),

                        ),
                      ),
                      SizedBox(height: size.height * 0.001),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // Soft shadow
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset:
                                    const Offset(2, 4), // Slight bottom shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: const Color.fromRGBO(124, 139, 160, 1.0)),
                              suffixIcon: const Icon(Icons.visibility_off, color: Color(0xFF61677D)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm Password cannot be empty";
                              }
                              if (value != passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),

                        ),
                      ),
                      SizedBox(height: size.height * 0.001),
                      Form_field(
                        hintText: "Pin Code",
                        controller: pincodeController,
                        prefixtext: "", validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Pin Code cannot be empty";
                        }
                        if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                          return "Enter a valid 6-digit pin code";
                        }
                        return null;
                      },

                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  value: isTermsAccepted,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isTermsAccepted = value ?? false; // Update checkbox state
                                      termsError = null; // Remove error when checked
                                    });
                                  },
                                  splashRadius: 5,
                                  side: const BorderSide(
                                    color: Color(0xFF003B8F),
                                    width: 1.0,
                                  ),
                                  activeColor: const Color(0xFF003B8F),
                                  checkColor: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: "I'm agree to the ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: "Terms of Service",
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xFF003B8F),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                          text: " and ",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13, fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: "Privacy Policy",
                                          style: GoogleFonts.roboto(
                                            color: const Color(0xFF003B8F),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => PoliciesScreen()),
                                              );
                                            }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (termsError != null) // Show error message if not checked
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                termsError!,
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  bool isFormValid = formKey.currentState!.validate();
                                  if (!isTermsAccepted) { // If checkbox is not checked
                                    setState(() {
                                      termsError = "Please accept the Terms and Privacy Policy.";
                                    });
                                    return; // Stop the function, don't proceed
                                  }

                                  setState(() {
                                    termsError = null; // Clear error if checkbox is checked
                                  });

                                  if (isFormValid && isTermsAccepted) {
                                    _signUp(); // Call signup function
                                  }
                                },

                                style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF003B8F),
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
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          )),
                        ],
                      ),
                      SizedBox(height: size.height * 0.001),

                      // Sign up text and button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Do you have account?",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF003B8F),
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
      ),
    );
  }
}
