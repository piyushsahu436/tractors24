import 'package:flutter/material.dart';
import 'package:tractors24/screens/policies_screen.dart';

class SearchTractor extends StatefulWidget {
  const SearchTractor({super.key});

  @override
  State<SearchTractor> createState() => _SearchTractorState();
}

class _SearchTractorState extends State<SearchTractor> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height * 0.27,
            width: double.infinity,
            decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/Vector3.png"))
          ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          ),
          Stack(
            children: [
              TextField(

              )
            ],
          )
        ],
      ),
    );
  }
}
