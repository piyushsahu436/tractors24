import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/otp_verification.dart';
import 'package:tractors24/screens/policies_screen.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final TextEditingController _emailverification = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/vector7.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 0),
              child: headerTemp(text: 'Forgot Password    '),
            )),
        Container(
          height: size.height * 0.2,
          width: size.width * 0.5,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/lockque.png'),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(children: [
            RichText(
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
              TextSpan(
                  text: 'Please Enter Your Email Address To \n     Receive A',
                  style: GoogleFonts.anybody(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  )),
              TextSpan(
                  text: ' Verification Code',
                  style: GoogleFonts.anybody(
                    color: const Color(0xFF003B8F),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ))
            ])),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form_field(
              hintText: 'Email',
              controller: _emailverification,
              prefixtext: ''),
        ),
        SizedBox(height: size.height * 0.06),
        SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.07,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtpVerf()),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
            child: Text(
              'Send',
              style: GoogleFonts.anybody(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
