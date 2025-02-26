import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridItem {
  final String imageUrl;
  final String title;

  GridItem({required this.imageUrl, required this.title});
}

class BrandGrids extends StatelessWidget {
  BrandGrids({super.key, required this.itemCount});
  final int itemCount;

  final List<GridItem> gridItems = [

    GridItem(imageUrl: 'assets/images/mahindraL.png', title: 'Mahindra'),
    GridItem(imageUrl: 'assets/images/PreetL.png', title: 'Preet Tractors'),

    GridItem(imageUrl: 'assets/images/marut.jpg', title: 'SMEA'),
    GridItem(imageUrl: 'assets/images/a-c-e-.jpg', title: 'ACE'),
    GridItem(imageUrl: 'assets/images/agri-king.jpg', title: 'Agri King'),
    GridItem(imageUrl: 'assets/images/autonxt.jpg', title: 'AutoNxt'),
    GridItem(imageUrl: 'assets/images/captain.jpg', title: 'Captain'),
    GridItem(imageUrl: 'assets/images/cellestial.jpg', title: 'Cellestial'),
    GridItem(imageUrl: 'assets/images/eicher.jpg', title: 'Eicher'),
    GridItem(imageUrl: 'assets/images/escorts.jpg', title: 'Escorts'),
    GridItem(imageUrl: 'assets/images/farmtrac.jpg', title: 'FARMTRAC'),
    GridItem(imageUrl: 'assets/images/force.jpg', title: 'Force'),
    GridItem(imageUrl: 'assets/images/hav.jpg', title: 'Hav'),
    GridItem(imageUrl: 'assets/images/hindustan.jpg', title: 'Hindustan'),
    GridItem(imageUrl: 'assets/images/indo-farm.jpg', title: 'Indo Farm Equipment Ltd.'),
    GridItem(imageUrl: 'assets/images/kartar.jpg', title: 'Kartar'),
    GridItem(imageUrl: 'assets/images/kubota.jpg', title: 'Kubota'),
    GridItem(imageUrl: 'assets/images/massey-ferguson.jpg', title: 'Massey Ferguson'),
    GridItem(imageUrl: 'assets/images/maxgreen.jpg', title: 'Maxgreen'),
    GridItem(imageUrl: 'assets/images/montra.jpg', title: 'Montra'),
    GridItem(imageUrl: 'assets/images/new-holland.jpg', title: 'New Holland'),
    GridItem(imageUrl: 'assets/images/powertrac.jpg', title: 'Power Trac'),
    GridItem(imageUrl: 'assets/images/same-deutz-fahr.jpg', title: 'Same Deutz Fahr'),
    GridItem(imageUrl: 'assets/images/solis.jpg', title: 'Solis'),
    GridItem(imageUrl: 'assets/images/standard.jpg', title: 'Standard'),
    GridItem(imageUrl: 'assets/images/swaraj.png.jpg', title: 'Swaraj'),
    GridItem(imageUrl: 'assets/images/trakstar.jpg', title: 'TRAKSTAR'),
    GridItem(imageUrl: 'assets/images/valdo.jpg', title: 'Valdo'),
    GridItem(imageUrl: 'assets/images/vst-shakti.jpg', title: 'VST Shakti'),
    GridItem(imageUrl: 'assets/images/JohnDeerL.png', title: 'John Deer'),
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
          childAspectRatio: 0.7, // Aspect ratio of each item
        ),
        itemCount: itemCount, // Number of items
        itemBuilder: (context, index) {
          final item = gridItems[index];
          return GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const Scaffold()));},
            child: Container(
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
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          child: Image.asset(
                            item.imageUrl,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(item.title,style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 8
                        ),),
                      ),
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}