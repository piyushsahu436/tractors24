import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/auth/login_password.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/Grids/Brand_Grids.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/Grids/StatesGrids.dart';
import 'package:tractors24/screens/HomePageF.dart';
import 'package:tractors24/screens/LandingPage.dart';
import 'package:tractors24/screens/buyer_page.dart';
import 'package:tractors24/screens/dealer_dashboard/home_screen.dart';
import 'package:tractors24/screens/faq_list.dart';
import 'package:tractors24/screens/loanEnquire.dart';
import 'package:tractors24/screens/new_password.dart';
import 'package:tractors24/screens/recommedWidget.dart';
import 'package:tractors24/screens/test.dart';
import 'package:tractors24/screens/update_profile_screen.dart';
import 'package:tractors24/screens/contact_seller.dart';
import 'package:tractors24/screens/profile_screen.dart';
import 'package:tractors24/screens/policies_screen.dart';
import 'package:tractors24/screens/faq_screen.dart';
import 'package:tractors24/auth/sign_up1.dart';
import 'package:tractors24/screens/DetailsPage.dart';
import 'package:tractors24/screens/Seller_form.dart';
import 'package:tractors24/screens/Seller_form2.dart';
import 'package:tractors24/screens/testimonials.dart';
import 'package:tractors24/screens/add_detailspage.dart';
import 'package:tractors24/screens/search.dart';
import 'package:tractors24/screens/notification.dart';
import 'package:tractors24/screens/dealer_dashboard/emi_cal.dart';
import 'package:tractors24/screens/avani.dart';
import 'package:tractors24/splash_screen/SplashScreen2.dart';
import 'package:tractors24/screens/forget_pass.dart';
import 'package:tractors24/screens/otp_verification.dart';
import 'package:tractors24/splash_screen/splashScreen1.dart';
import 'package:tractors24/screens/wallet.dart';
import 'package:tractors24/screens/Grids/MyAds.dart';
import 'package:tractors24/screens/AllItems.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';




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
        builder: (context) => isFirstTime ? SplashScreen5() : LoginPage(),
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

