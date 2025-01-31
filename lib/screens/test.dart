/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/auth/sign_up1.dart';
import 'package:tractors24/screens/HomePageF.dart';
import 'package:tractors24/screens/LandingPage.dart';

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
  // void _login(BuildContext context) {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }
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
          .collection('tractors24')
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
                        prefixtext: ""),
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
                    // TextField(
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     hintText: 'Password',
                    //     hintStyle: GoogleFonts.anybody(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 16,
                    //         color: Color.fromRGBO(124, 139, 160, 1.0)),
                    //     suffixIcon: Icon(Icons.visibility_off,
                    //         color: Color(
                    //             0xFF61677D)), //have to make this icon functional
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //     contentPadding:
                    //         EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //   ),
                    // ),
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
                            side: const BorderSide(
                              color: Color(0xFF003B8F),
                              width: 1.0,
                            ),
                            activeColor: const Color(
                                0xFF003B8F), // Optional: Color when the checkbox is checked
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
                                    style: GoogleFonts.anybody(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                                TextSpan(
                                  text: "Term's of Service",
                                  style: GoogleFonts.anybody(
                                    color: const Color(0xFF003B8F),
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
                                    color: const Color(0xFF003B8F),
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
                    const SizedBox(height: 16),
                    Container(
                      width: 320,
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tractors24/auth/login_page.dart';
// import 'package:tractors24/auth/login_password.dart';

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
  bool isTermsAccepted = false;
  bool isLoading = false;
  bool isCustomerSelected = true;

  // void _login(BuildContext context) {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }
  Future<void> _signUp() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('tractors24')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'userType': userType,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Successful')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login2()));
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
                                style: GoogleFonts.anybody(
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
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "I`m a",
                                style: GoogleFonts.anybody(
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
                                      ],

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.01),

                          Form_field(
                              hintText: "Name",
                              controller: nameController,
                              prefixtext: ""),
                          SizedBox(height: size.height * 0.001),
                          Form_field(
                              hintText: "Email",
                              controller: emailController,
                              prefixtext: ""),
                          SizedBox(height: size.height * 0.0001),
                          Form_field(
                              hintText: "Phone Number",
                              controller: phoneController,
                              prefixtext: ""),
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
                                controller: passwordController,
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
                          SizedBox(height: size.height * 0.001),
                          Padding(
                            padding: const  EdgeInsets.symmetric(vertical: 3.0),
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
                                controller: confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
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
                                  splashRadius: 5,
                                  side: const BorderSide(
                                    color: Color(0xFF003B8F),
                                    width: 1.0,
                                  ),
                                  activeColor: const Color(
                                      0xFF003B8F), // Optional: Color when the checkbox is checked
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
                                          style: GoogleFonts.anybody(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: "Term's of Service",
                                        style: GoogleFonts.anybody(
                                          color: const Color(0xFF003B8F),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                          text: " and ",
                                          style: GoogleFonts.anybody(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: GoogleFonts.anybody(
                                          color: const Color(0xFF003B8F),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed:isLoading
                                      ? null
                                      : () {
                                    if (formKey.currentState!.validate()) {
                                      _signUp();  // Call sign-up function only if valid
                                    }
                                  },
                                  // isTermsAccepted ? () => _login(context) : null,
                                  style: ElevatedButton.styleFrom(
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
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                                  style: GoogleFonts.anybody(
                                      fontWeight: FontWeight.w400),
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
                                    'Sign In',
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
            ),
        );
    }
}*/
