import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:tractors24/screens/loanEnquire.dart";
import 'package:tractors24/screens/policies_screen.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height*0.1,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(fit: BoxFit.fill,
                        image: AssetImage("assets/images/vector5.png"))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 0),
                  child: headerTemp(text: ""),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                      child: Text("Mahindra Arjun 555 DI",
                        style: GoogleFonts.anybody(color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
              // Image section
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(height: size.height*0.37),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                      height: size.height*0.3,
                      decoration: const BoxDecoration(
                          image: DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://c8.alamy.com/comp/DTRKEM/tractor-with-trailer-rajasthan-india-DTRKEM.jpg"))
                      ),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 35,right: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.favorite_border,color: Colors.redAccent,)
                              ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15,right: 15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                              const Icon(Icons.camera_alt_sharp,color: Colors.white,),
                              Text("2", style: GoogleFonts.anybody(color: Colors.white),),
                            ],),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 225,left: 18,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://i.tribune.com.pk/media/images/161722544519-1/161722544519-1.jpg")),
                            border: Border.all(
                                color: Colors.white,
                                width: 2
                            ),
                          ),
                          height: size.height*0.10,
                          width: size.width*0.25,
                        ),
                        SizedBox(width: size.width*0.04,),

                        Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://www.livehindustan.com/lh-img/uploadimage/library/2022/06/12/16_9/16_9_6/nitish_kumar_government_started_process_of_realising_39_crore_from_51_000_farmers_who_received_pm_ki_1655001196.jpg")),
                            border: Border.all(
                                color: Colors.white,
                                width: 2
                            ),
                          ),
                          height: size.height*0.10,
                          width: size.width*0.25,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Title and price section
              Padding(
                padding: const EdgeInsets.only(top: 0,left: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            '₹ 7,30,000',
                            style: GoogleFonts.anybody(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Loanenquire()));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: const BorderSide(color:  Color(0xFF003B8F),
                                width: 1.5),
                            backgroundColor: const Color(0xFF003B8F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text('Apply loan',
                            style: GoogleFonts.anybody(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                            ),),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular( 6.9),
                                      color: Colors.blue[50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child: const Icon(
                                      Icons.speed,
                                      color: Colors.black,
                                      size: 24.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "30,000",
                                    style: GoogleFonts.anybody(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Text(
                                    "kms",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.anybody(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular( 6.9),
                                      color: Colors.blue[50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child:  Image.asset(
                                      'assets/icons/calendar2.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "2023",
                                    style: GoogleFonts.anybody(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Model",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.anybody(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular( 6.9),
                                      color: Colors.blue[50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child:  Image.asset(
                                      'assets/icons/gas.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "Diesel",
                                    style: GoogleFonts.anybody(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Fuel Type",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.anybody(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular( 6.9),
                                      color: Colors.blue[50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child:  Image.asset(
                                      'assets/icons/placeholder.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    "Indore",
                                    style: GoogleFonts.anybody(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Location",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.anybody(
                                      color: Colors.grey[600],
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tabs
              const TabBarSection(),
              SizedBox(height: size.height*0.015,),
              // Details
              // const DetailsSection(),
              // SizedBox(height: size.height*0.015,),




            ],
          ),
        ),
      ),
    );
  }
}
class TabBarSection extends StatefulWidget {
  const TabBarSection({super.key});

  @override
  _TabBarSectionState createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection> {
  bool isSpecificationSelected  = true; // Default selection

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get screen size

    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSpecificationSelected = true;
                      });
                    },
                    child: Container(
                      height: size.height * 0.04,
                      width: size.width * 5,
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSpecificationSelected ? const Color(0xFF003B8F) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        //border: Border.all(color: Color(0xFF003B8F), width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Specifications",
                        style: GoogleFonts.anybody(
                          color: isSpecificationSelected ? Colors.white : const Color(0xFF003B8F),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSpecificationSelected = false;
                      });
                    },
                    child: Container(
                      height: size.height * 0.04,
                      width: size.width * 5,
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        color: !isSpecificationSelected ? const Color(0xFF003B8F) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Features",
                        style: GoogleFonts.anybody(
                          color: !isSpecificationSelected ? Colors.white : const Color(0xFF003B8F),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DetailsSection(isSpecificationSelected: isSpecificationSelected),
        ],
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  final bool isSpecificationSelected;
  const DetailsSection({super.key, required this.isSpecificationSelected});

  @override
  Widget build(BuildContext context) {
    final details = [
      {'label': 'Brand', 'value': 'Tata'},
      {'label': 'Model', 'value': '1'},
      {'label': 'Registration Year', 'value': 'Jan 2026'},
      {'label': 'Rear Tire', 'value': '-'},
      {'label': 'Registration Number', 'value': '456'},
      {'label': 'Insurance Status', 'value': '6 days ago'},
      {'label': 'Engine oil Capacity', 'value': '456'},
      {'label': 'Fuel', 'value': '-'},
    ];
    final features = [
      {'label': 'Horse Power', 'value': 'ABC'},
      {'label': 'Steering Type', 'value': 'ABC'},
      {'label': 'Break', 'value': 'ABC'},
      {'label': 'Transmission', 'value': 'ABC'},
      {'label': 'PTO', 'value': 'ABC'},
      {'label': 'CC', 'value': 'ABC'},
      {'label': 'Lifting Capacity', 'value': 'ABC'},
      {'label': 'Cooling', 'value': 'ABC'},
    ];

    final dataToShow = isSpecificationSelected ? details : features;

    return Column(
      children: dataToShow.asMap().entries.map((entry){
        final index = entry.key;
        final item = entry.value;

        return Container(
          color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['label']!,
                style: GoogleFonts.anybody(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),
              ),
              Text(
                item['value']!,
                style: GoogleFonts.anybody(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
