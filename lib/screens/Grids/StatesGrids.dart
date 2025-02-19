import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StateItem {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onTapp;

  StateItem(
      {required this.imageUrl,
      required this.title,
      required this.subtitle,
      required this.onTapp});
}

class StateGrids extends StatelessWidget {
  StateGrids({super.key});

  final List<StateItem> stateItems = [
    StateItem(
        imageUrl: 'assets/images/state1.png',
        title: 'Andhra Pradesh',
        subtitle: 'Available District - 15',
        onTapp: () {
          const Scaffold();
        }),
    StateItem(
        imageUrl: 'assets/images/state2.png',
        title: 'Arunachal Pradesh',
        subtitle: 'Available District - 25',
        onTapp: () {
          const Scaffold();
        }),
    StateItem(
        imageUrl: 'assets/images/madhya.png',
        title: 'Madhya Pradesh',
        subtitle: 'Available District - 18',
        onTapp: () {
          const Scaffold();
        }),
    StateItem(
        imageUrl: 'assets/images/State3.png',
        title: 'Nagaland',
        subtitle: 'Available District - 13',
        onTapp: () {
          const Scaffold();
        }),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 2.0, // Spacing between rows
          childAspectRatio: 0.7, // Aspect ratio of each item
        ),
        itemCount: stateItems.length, // Number of items
        itemBuilder: (context, index) {
          final item = stateItems[index];
          return GestureDetector(
            onTap: item.onTapp,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 186,
                      height: 129,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                           BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.5, 0.99),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.title,
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF003B8F),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.subtitle,
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top:
                          -40, // Adjust to control how much of the image overlaps
                      child: CircleAvatar(
                        radius: size.width*0.11,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(item.imageUrl),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
