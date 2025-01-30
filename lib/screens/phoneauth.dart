import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tractors24/auth/otpScreen.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: "Enter Phone Number",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationid, int? resendtoken) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>otpScreen(verificationid: verificationid,)));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    phoneNumber: phoneController.text.toString());
              },
              child: const Text("Verify Phone Number"))
        ],
      ),
    );
  }
}
