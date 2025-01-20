import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tractors24/screens/homepage.dart';
import 'dart:developer';


class otpScreen extends StatefulWidget {
  String verificationid;
  otpScreen({super.key, required this.verificationid});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                suffixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                          verificationId: widget.verificationid,
                          smsCode: otpController.text.toString());
                  FirebaseAuth.instance.signInWithCredential(credential).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                  });
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child: const Text("OTP"))
        ],
      ),
    );
  }
}
