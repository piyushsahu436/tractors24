import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/otp_verification.dart';
import 'package:tractors24/screens/policies_screen.dart';

class OtpVerf extends StatefulWidget {
  const OtpVerf({super.key});

  @override
  State<OtpVerf> createState() => _OtpVerfState();
}

class _OtpVerfState extends State<OtpVerf> {
  final mobileControllerotp = TextEditingController();
  final int fieldCount = 4; // Number of OTP fields
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/vector7.png'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 0),
                child: headerTemp(text: 'Verify Your Email'),
              )),
          Container(
            height: size.height * 0.2,
            width: size.width * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/message.png'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'Please Enter the 4 digit code sent to',
              style: GoogleFonts.anybody(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            'Abc@gmail.com',
            style: GoogleFonts.anybody(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color(0xFF003B8F)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Column(
                children: [
                  Text("Enter OTP",
                      style: GoogleFonts.anybody(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF003B8F),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        fieldCount,
                            (index) => Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: 50,
                            child: TextField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                counterText: '',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                  BorderSide(color: Color(0xFF003B8F)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty &&
                                    index < fieldCount - 1) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNodes[index + 1]);
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNodes[index - 1]);
                                }
                              },
                              onSubmitted: (value) {
                                if (index == fieldCount - 1) {
                                  FocusScope.of(context)
                                      .unfocus(); // Dismiss the keyboard
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Resend Code in : In 10:40 Sec",
                        style: GoogleFonts.anybody(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ),

                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: (){},
                      // onPressed: () async {
                      //   try {
                      //     PhoneAuthCredential credential =
                      //         PhoneAuthProvider.credential(
                      //             verificationId: widget.verificationid,
                      //             smsCode: controllers.text.toString());
                      //     FirebaseAuth.instance
                      //         .signInWithCredential(credential)
                      //         .then((value) {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => const HomePage()));
                      //     });
                      //   } catch (ex) {
                      //     log(ex.toString());
                      //   }
                      // },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF003B8F),
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Verify',
                        style: GoogleFonts.anybody(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
