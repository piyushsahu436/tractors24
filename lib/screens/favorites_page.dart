import 'package:flutter/material.dart';
import 'package:tractors24/screens/policies_screen.dart';


class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
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
        child: headerTemp(text: 'F'),
      ) ,
    );
  }
}