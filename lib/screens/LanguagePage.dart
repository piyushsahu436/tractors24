import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as rive;
import 'package:tractors24/auth/login_page.dart';
import 'package:tractors24/screens/test.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String? _selectedLanguage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.45,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Vector3.png"),
                  fit: BoxFit.fill),
            ),
            child: Stack(
              children: [
                Positioned(
                    right: 20,
                    top: 20,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  LoginPage(),),);
                        },
                        child: Text(
                          "Skip",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ))),
                Positioned(
                    bottom: size.height * 0.01,
                    left: size.width * 0.1,
                    right: size.width * 0.1,
                    child: Image.asset("assets/images/img.png")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Choose Your Language",
              style: GoogleFonts.roboto(
                color: const Color(0xFF252828),
                fontSize: 24.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3,
                children: [
                  _buildLanguageOption("English", "English"),
                  _buildLanguageOption("Hindi", "हिंदी"),
                  _buildLanguageOption("Tamil", "தமிழ்"),
                  _buildLanguageOption("Malayalam", "മലയാളം"),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            "You can change language in settings",
            style: GoogleFonts.roboto(
              color: const Color(0xFF252828),
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 23, right: 23, bottom: 40, top: 8),
            child: Container(
              height: size.height * 0.05,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>  LoginPage(),),);
                  anime(image: 'third', seconds: 2, nextClass: LoginPage());

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(nextScreen: LoginPage(), image: 'thirdF')));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: const Color(0xFF003B8F),
                ),
                child: Text(
                  "Next",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String value, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio<String>(
          value: value,
          focusColor: Color(0xFF252828),
          activeColor: Color(0xFF252828),
          groupValue: _selectedLanguage,
          onChanged: (value) {
            setState(() {
              _selectedLanguage = value;
            });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.roboto(
                color: const Color(0xFF252828),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.grey,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FullScreen extends StatefulWidget {
  final Widget nextScreen;
  final String image;

  const FullScreen({super.key, required this.nextScreen, required this.image});

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  rive.SMITrigger? _trigger;
  late rive.RiveAnimationController _controller;

  void _onRiveInit(rive.Artboard artboard) {
    final controller = rive.StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);
      final triggerInput = controller.findInput<rive.SMITrigger>('Trigger 1');
      if (triggerInput != null) {
        _trigger = triggerInput as rive.SMITrigger?;
        print("✅ Trigger assigned successfully");
      } else {
        print("❌ Trigger not found");
      }

    }
  }

  void _playAnimationAndNavigate() {
    if (_trigger != null) {
      print("🔥 Firing trigger...");
      _trigger!.fire();
      Future.delayed(const Duration(seconds: 2), () {  // Adjust time based on animation duration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.nextScreen),
        );
      });
    } else {
      print("❌ Cannot play animation: Trigger is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          rive.RiveAnimation.asset(
            'assets/animations/${widget.image}',
            fit: BoxFit.cover,
            onInit: _onRiveInit,
          ),
        ],
      ),
    );
  }
}
