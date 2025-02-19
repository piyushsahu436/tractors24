import 'package:flutter/material.dart';

class ExpandOnTapScreen extends StatefulWidget {
  const ExpandOnTapScreen({super.key});

  @override
  State<ExpandOnTapScreen> createState() => _ExpandOnTapScreenState();
}

class _ExpandOnTapScreenState extends State<ExpandOnTapScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: double.infinity,
          color: isExpanded ? const Color(0xFF0A2472) : Colors.transparent,
          child: Center(
            child: isExpanded
                ? const SizedBox() // Hide image when expanded
                : Image.asset(
              'assets/images/firstt.png', // Replace with your image
              width: 250,
              height: 250,
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class AnimatedContainerWidget extends StatefulWidget {
//   const AnimatedContainerWidget({super.key});
//
//   @override
//   State<AnimatedContainerWidget> createState() =>
//       _AnimatedContainerWidgetState();
// }
//
// class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
//   double height = 100;
//   double width = 100;
//   Color color = Color(0xFF0A2472);
//   BorderRadiusGeometry radiusGeometry = BorderRadius.circular(8);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Center(
//           child: AnimatedContainer(
//             height: height,
//             width: width,
//             decoration:
//             BoxDecoration(color: color, borderRadius: radiusGeometry),
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.fastOutSlowIn,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: IconButton(
//               onPressed: () {
//                 final random = Random();
//                 height = random.nextInt(150).toDouble();
//                 width = random.nextInt(300).toDouble();
//
//                 color = Color.fromRGBO(random.nextInt(256), random.nextInt(256),
//                     random.nextInt(256), 1);
//
//                 radiusGeometry =
//                     BorderRadius.circular(random.nextInt(100).toDouble());
//                 setState(() {});
//               },
//               icon: const Icon(Icons.refresh),color: Colors.white,),
//         )
//       ],
//     );
//   }
// }
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// //
// // class Splashscreen1 extends StatefulWidget {
// //
// //   const Splashscreen1({super.key});
// //
// //   @override
// //   State<Splashscreen1> createState() => _Splashscreen1State();
// // }
// //
// // class _Splashscreen1State extends State<Splashscreen1> {
// //   // AnimationController animationController;
// //   // Animation<double> animation;
// //   // @override
// //   // void initState() {
// //   //   super.initState();
// //   //   animationController = AnimationController(
// //   //     vsync: this,
// //   //     duration: Duration(milliseconds: 1000),
// //   //   );
// //   //   animation = CurvedAnimation(
// //   //     parent: animationController,
// //   //     curve: Curves.easeIn,
// //   //   );
// //   // }
// //
// //   bool _isClicked = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           // Animated background color spread
// //           AnimatedContainer(
// //             duration: const Duration(seconds: 2),
// //             curve: Curves.easeInOut,
// //             decoration: BoxDecoration(
// //               color: _isClicked ? Color(0xFF116978) : Colors.transparent,
// //             ),
// //           ),
// //           // CircularRevealAnimation(child: Container(color: Color(0xFF116978)), centerAlignment: Alignment.centerRight,
// //           //   // 0 if not specified
// //           //   minRadius: 12,
// //           //   // distance from center to further child's corner if not specified
// //           //   maxRadius: 200, animation: animation,),
// //           // // Center image
// //           Center(
// //             child: GestureDetector(
// //               onTap: () {
// //                 setState(() {
// //                   _isClicked = !_isClicked; // Toggle the color spread
// //                 });
// //               },
// //               child: SvgPicture.asset(
// //                 'assets/images/Vector.svg', // Replace with your image asset
// //                 width: 150, // Adjust as needed
// //                 height: 150,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
