import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main.dart'; // Import main.dart for MyHomePage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _textAnimation;
  final String _text = "Tractors 24"; // Text to display
  final int _textLength = 8; // Total number of characters

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    // Create an integer animation for the text length
    _textAnimation = IntTween(begin: 0, end: _textLength).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild on every animation frame
      });

    // Start the animation
    _controller.forward();

    // Navigate to the home page after the animation and delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              _text.substring(0, _textAnimation.value), // Display partial text
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}