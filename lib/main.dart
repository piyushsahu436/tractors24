import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/auth/login_password.dart';
import 'package:tractors24/screens/LandingPage.dart';
import 'package:tractors24/screens/testimonials.dart';
import 'package:tractors24/splash_screen/SplashScreen2.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
late RiveAnimationController _controller;


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Timeline 1');  // Start Rive animation
    _startSplashSequence();  // Check login status after animation
  }

  Future<void> _startSplashSequence() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // Wait for the animation to complete (4s)
    await Future.delayed(const Duration(seconds: 4));

    if (!mounted) return;

    // Navigate based on login status
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isFirstTime ? SplashScreen5() : Login2(),
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // At the end of the video i will show you
          // How to create that animation on Rive
          // Let's add blur

          RiveAnimation.asset("assets/animations/splash", fit: BoxFit.cover,controllers: [_controller],),
        ], // Stack
      ),
    );
  }
}

