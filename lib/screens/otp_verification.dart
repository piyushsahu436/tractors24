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
          )
        ],
      ),
    );
  }
}
