import 'package:flutter/material.dart';
import 'package:tractors24/screens/policies_screen.dart';


class news extends StatefulWidget {
  const news({super.key});

  @override
  State<news> createState() => _newsState();
}

class _newsState extends State<news> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
height: size.height*0.2,
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('assets/images/vector7.png'),
          fit: BoxFit.cover)
        ),
        child: headerTemp(text: 'News'),
      ) ,
    );
  }
}
