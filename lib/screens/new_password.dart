import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/policies_screen.dart';

class NewPassword extends StatelessWidget {
  NewPassword({super.key});
  final TextEditingController _newpass = TextEditingController();
  final TextEditingController _cnfpass = TextEditingController();
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
                child: headerTemp(text: 'Create New Password'),
              )),
          Container(
            height: size.height * 0.2,
            width: size.width * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/lockright.png'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                    TextSpan(
                        text: '  Your ',
                        style: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        )),
                    TextSpan(
                        text: 'New Password ',
                        style: GoogleFonts.anybody(
                          color: const Color(0xFF003B8F),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        )),
                    TextSpan(
                        text:
                            'Must Be Different\n        From Previously Used Password',
                        style: GoogleFonts.anybody(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        )),
                  ])),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form_field(
                hintText: 'New Password', controller: _newpass, prefixtext: ''),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form_field(
                hintText: 'Confirm Password',
                controller: _cnfpass,
                prefixtext: ''),
          ),
          SizedBox(height: size.height * 0.04),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.07,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )), 
                child: Text(
                  'Send',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
