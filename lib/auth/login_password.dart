import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/auth/sign_up1.dart';
import 'package:tractors24/screens/HomePageF.dart';
import 'package:tractors24/screens/LandingPage.dart';
import 'package:tractors24/screens/profile_screen.dart';
import '../screens/dealer_dashboard/home_screen.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _LoginPage2();
}

class _LoginPage2 extends State<Login2> {
  final TextEditingController nameloginController = TextEditingController();
  final TextEditingController passwordloginController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isTermsAccepted = false;
  bool isLoading = false;
  bool isCustomerSelected = true;
  void _loging(BuildContext context) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  Future<void> _login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: nameloginController.text.trim(),
        password: passwordloginController.text.trim(),
      );

      if (!mounted) return;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (!userDoc.exists) {
        throw 'User data not found';
      }

      if (!mounted) return;

      final userType = userDoc.data()?['userType'] as String?;
      final route = MaterialPageRoute(
        builder: (_) => userType == 'Customer' ? const LandingPage() :  DealerDashboard(),
      );

      Navigator.pushReplacement(context, route);

    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'user-not-found' => 'No user found for that email',
        'wrong-password' => 'Wrong password provided',
        _ => 'Authentication failed: ${e.message}',
      };
      _showError(message);
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                  height: size.height * 0.3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Vector4.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Image(
                      image: const AssetImage("assets/images/img.png"),
                      height: size.height * 0.2,
                      width: size.width * 0.5)),

              SizedBox(height: size.height * 0.01),

              // Logo image in circle
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
                      height: size.width * 0.25,
                      width: size.width * 0.25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text('Login',
                          style: GoogleFonts.anybody(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF003B8F),
                          )),
                    ),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isCustomerSelected = true;
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
                                      style: GoogleFonts.anybody(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF61677D)),
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
                        hintText: "Email",
                        controller: nameloginController,
                        prefixtext: "", validator: (String? value) {  },),
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
                        child: TextField(
                          controller: passwordloginController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.anybody(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color.fromRGBO(124, 139, 160, 1.0)),
                            suffixIcon: const Icon(Icons.visibility_off,
                                color: Color(0xFF61677D)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(height: 50,),

                        _buildClickableTexts(" Forget Password?", "")
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 340,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:isLoading
                            ? null
                            : () {
                          if (formKey.currentState!.validate()) {
                            _login(context);  // Call sign-up function only if valid
                          }
                        },// isTermsAccepted ? () => _login(context) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003B8F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),

                    // Sign up text and button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Don't have account? ",
                            style:
                            GoogleFonts.anybody(fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp1(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.anybody(
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
    );
  }
}


Widget _buildClickableTexts(String clickText, String description) {
  return Row(
    children: [
      Text(
        '$clickText ',
        style: GoogleFonts.anybody(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 59, 143, 1),

        ),
      ),
      Text(description, style: GoogleFonts.anybody(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),),
    ],
  );
}