import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _textAnimation;
  final String _text = "Let us wheel \n Your Dreams"; // Text to display

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with appropriate duration
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _text.length * 250), // 250 ms per character
    );

    // Create an integer animation for the text length
    _textAnimation = IntTween(begin: 0, end: _text.length).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild on every animation frame
      });

    // Start the animation
    _controller.forward();

    // Use a non-nullable duration
    Future.delayed(_controller.duration!, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  const LoginPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              _text.substring(0, _textAnimation.value.clamp(0, _text.length)), // Clamp the value
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
