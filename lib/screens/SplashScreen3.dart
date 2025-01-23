import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/LanguagePage.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: const Color(0xFF116978),

      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    //  navigation to next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // Replace NextScreen with your actual next screen
                        builder: (context) =>  LanguagePage(),
                      ),
                    );
                  },
                  child:  Text(
                    'Skip',
                    style:  GoogleFonts.anybody(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 300, // Adjust as needed
                height: 100,
                child: Image.asset(
                  'assets/images/LOGO.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox( width: 300,
              child: Text(
                'EASY TO BUY AND SELL VEHICLE',textAlign: TextAlign.center,
                style:  GoogleFonts.anybody(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: size.height*0.02,),

            // Tractor image
            Padding(
              padding: const EdgeInsets.all(20),
              // Replace with your actual image path
              child: Image.asset(
                'assets/images/grp11.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Buy Certified Used Vehicle From Trusted Seller. Sel Your vehicle in quick easy steps',
                textAlign: TextAlign.center,
                style:  GoogleFonts.anybody(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Next button at bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 35),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox(width: 76,)),
                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width:76,height:4 ,
                            child: const Image(image: AssetImage("assets/images/grp1.png"))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        // Add navigation to next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // Replace NextScreen with your actual next screen
                            builder: (context) => NextScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Next',
                        style:  GoogleFonts.anybody(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],),
            )

          ],
        ),
      ),
    );
  }
}

// Temporary NextScreen class - replace with your actual next screen
class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Next Screen'),
      ),
    );
  }
}