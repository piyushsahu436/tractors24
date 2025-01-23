import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _LoginPage2();
}

class _LoginPage2 extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    bool _termsChecked = false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Vector.png'),
                      fit: BoxFit.fill),
                ),
                child: Image(
                    image: AssetImage("assets/images/img.png"),
                    height: size.height * 0.2,
                    width: size.width * 0.5)),

            SizedBox(height: size.height * 0.01),

            // Logo image in circle
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
                    child: Text('Login',
                        style: GoogleFonts.anybody(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF116978),
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
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Name/Email',
                      hintStyle: GoogleFonts.anybody(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  SizedBox(height: size.height * 0.001),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color.fromRGBO(124, 139, 160, 1.0)
                      ),
                     suffixIcon:
                          Icon(Icons.visibility_off, color: Color(0xFF61677D)),//have to make this icon functional
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),



      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CheckboxListTile(
          title: RichText(
            text: TextSpan(
              text: "I agree to the ",
              children: [
                TextSpan(
                  text: "Terms",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    // Navigate to Terms page
                  },
                ),
                TextSpan(text: " and "),
                TextSpan(
                  text: "Privacy",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    // Navigate to Privacy page
                  },
                ),
              ],
            ),
          ),
          value: _termsChecked,
          onChanged: (value) => setState(() { _termsChecked = value ?? false; }),
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
}
