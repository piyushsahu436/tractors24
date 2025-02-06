import 'package:flutter/material.dart';
import 'package:tractors24/screens/policies_screen.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height*0.1,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill,
                    image: AssetImage("assets/images/vector5.png"))
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 0),
              child: headerTemp(text: "Notification"),
            ),
          ),
          Container(

          )
        ],
      ),
    ));
  }
}
