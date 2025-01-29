
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splashscreen1 extends StatefulWidget {

  const Splashscreen1({super.key});

  @override
  State<Splashscreen1> createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen1> {
  // AnimationController animationController;
  // Animation<double> animation;
  // @override
  // void initState() {
  //   super.initState();
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 1000),
  //   );
  //   animation = CurvedAnimation(
  //     parent: animationController,
  //     curve: Curves.easeIn,
  //   );
  // }

  bool _isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background color spread
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _isClicked ? Color(0xFF116978) : Colors.transparent,
            ),
          ),
          // CircularRevealAnimation(child: Container(color: Color(0xFF116978)), centerAlignment: Alignment.centerRight,
          //   // 0 if not specified
          //   minRadius: 12,
          //   // distance from center to further child's corner if not specified
          //   maxRadius: 200, animation: animation,),
          // // Center image
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isClicked = !_isClicked; // Toggle the color spread
                });
              },
              child: SvgPicture.asset(
                'assets/images/Vector.svg', // Replace with your image asset
                width: 150, // Adjust as needed
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
