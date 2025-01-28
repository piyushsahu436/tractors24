import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridItem {
  final String imageUrl;
  final String title;

  GridItem({required this.imageUrl, required this.title});
}

class BrandGrids extends StatelessWidget {
  BrandGrids({super.key});

  final List<GridItem> gridItems = [
    GridItem(imageUrl: 'assets/images/JohnDeerL.png', title: 'John Deer'),
    GridItem(imageUrl: 'assets/images/mahindraL.png', title: 'Mahindra'),
    GridItem(imageUrl: 'assets/images/PreetL.png', title: 'Preet Tractors'),
    GridItem(imageUrl: 'assets/images/SonalikaL.png', title: 'Sonalika'),
    GridItem(imageUrl: 'assets/images/JohnDeerL.png', title: 'John Deer'),
    GridItem(imageUrl: 'assets/images/mahindraL.png', title: 'Mahindra'),
    GridItem(imageUrl: 'assets/images/PreetL.png', title: 'Preet Tractors'),
    GridItem(imageUrl: 'assets/images/SonalikaL.png', title: 'Sonalika'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 20.0, // Spacing between rows
          childAspectRatio: 0.9, // Aspect ratio of each item
        ),
        itemCount: gridItems.length, // Number of items
        itemBuilder: (context, index) {
          final item = gridItems[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.5, 0.99),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Text(item.title,style: GoogleFonts.anybody(
                  fontWeight: FontWeight.w500,
                  fontSize: 8
                ),),
              ],
            )
          );
        },
      ),
    );
  }
}
