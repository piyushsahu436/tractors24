import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import "package:tractors24/screens/loanEnquire.dart";
import 'package:tractors24/screens/policies_screen.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage(
      {super.key,
      required this.SellPrice,
      required this.brand,
      required this.model,
      required this.RegYear,
      required this.Pincode,
      required this.HorsePower,
      required this.Hours,
      required this.RegNum,
      required this.InsStatus,
      required this.RearTire,
      required this.Address,
      required this.Break,
      required this.Transmission,
      required this.PTO,
      required this.CC,
      required this.Cooling,
      required this.LiftingCapacity,
      required this.SteeringType,
      required this.ClutchType,
      required this.OilCap,
      required this.RunningKM,
      required this.Fuel,
      required this.tractorId,
      this.imageUrls});
  final String SellPrice;
  final String brand;
  final String model;
  final String RegYear;
  final String Pincode;
  final String HorsePower;
  final String Hours;
  final String RegNum;
  final String InsStatus;
  final String RearTire;
  final String Address;
  final String tractorId;
  final String Break;
  final String Transmission;
  final String PTO;
  final String CC;
  final String Cooling;
  final String LiftingCapacity;
  final String SteeringType;
  final String ClutchType;
  final String OilCap;
  final String RunningKM;
  final String Fuel;
  final List<String>? imageUrls;

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
                height: size.height * 0.1,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/vector5.png"))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0),
                  child: headerTemp(text: ""),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        '${brand} ${model}',
                        style: GoogleFonts.anybody(
                            color: Colors.black,
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
                    padding: const EdgeInsets.only(top: 0),
                    child: ImageSliderWidget(
                      imageUrls: imageUrls,
                    ),
                    // child: Container(
                    //   height: size.height * 0.3,
                    //   decoration: const BoxDecoration(
                    //       image: DecorationImage(
                    //           fit: BoxFit.fill,
                    //           image: NetworkImage(
                    //               "https://c8.alamy.com/comp/DTRKEM/tractor-with-trailer-rajasthan-india-DTRKEM.jpg"))),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Padding(
                    //         padding: EdgeInsets.only(top: 35, right: 15),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             Icon(
                    //               Icons.favorite_border,
                    //               color: Colors.redAccent,
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding:
                    //             const EdgeInsets.only(bottom: 15, right: 15),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             const Icon(
                    //               Icons.camera_alt_sharp,
                    //               color: Colors.white,
                    //             ),
                    //             Text(
                    //               "2",
                    //               style:
                    //                   GoogleFonts.anybody(color: Colors.white),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                ],
              ),
              // Title and price section
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.9),
                                      color: Colors.blue[
                                          50], // Light blue background only for icon
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
                                    '${RunningKM}',
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.9),
                                      color: Colors.blue[
                                          50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child: Image.asset(
                                      'assets/icons/calendar2.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    '${RegYear}',
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.9),
                                      color: Colors.blue[
                                          50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child: Image.asset(
                                      'assets/icons/gas.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    Fuel,
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.9),
                                      color: Colors.blue[
                                          50], // Light blue background only for icon
                                      // Makes it circular
                                    ),
                                    child: Image.asset(
                                      'assets/icons/placeholder.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    '${Pincode}',
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹ ${SellPrice}',
                            style: GoogleFonts.anybody(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Loanenquire()));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              side: const BorderSide(
                                  color: Color(0xFF003B8F), width: 1.5),
                              backgroundColor: const Color(0xFF003B8F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Apply loan',
                              style: GoogleFonts.anybody(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),

              // Tabs
              TabBarSection(
                isSpecificationSelected:
                    true, // Toggle between details and features
                brand: brand,
                model: model,
                regYear: RegYear,
                rearTire: RearTire,
                regNum: RegNum,
                insStatus: InsStatus,
                oilCap: OilCap,
                fuel: Fuel,
                horsePower: HorsePower.toString(), // Convert Double to String
                steeringType: SteeringType,
                brake: Break,
                transmission: Transmission,
                pto: PTO,
                cc: CC,
                liftingCapacity: LiftingCapacity,
                cooling: Cooling,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
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
  const TabBarSection(
      {super.key,
      required this.isSpecificationSelected,
      required this.brand,
      required this.model,
      required this.regYear,
      required this.rearTire,
      required this.regNum,
      required this.insStatus,
      required this.oilCap,
      required this.fuel,
      required this.horsePower,
      required this.steeringType,
      required this.brake,
      required this.transmission,
      required this.pto,
      required this.cc,
      required this.liftingCapacity,
      required this.cooling});
  final bool isSpecificationSelected;
  final String brand;
  final String model;
  final String regYear;
  final String rearTire;
  final String regNum;
  final String insStatus;
  final String oilCap;
  final String fuel;
  final String horsePower;
  final String steeringType;
  final String brake;
  final String transmission;
  final String pto;
  final String cc;
  final String liftingCapacity;
  final String cooling;

  @override
  _TabBarSectionState createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection> {
  bool isSpecificationSelected = true; // Default selection

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
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSpecificationSelected
                            ? const Color(0xFF003B8F)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        //border: Border.all(color: Color(0xFF003B8F), width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Specifications",
                        style: GoogleFonts.anybody(
                          color: isSpecificationSelected
                              ? Colors.white
                              : const Color(0xFF003B8F),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 20),
                      decoration: BoxDecoration(
                        color: !isSpecificationSelected
                            ? const Color(0xFF003B8F)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Features",
                        style: GoogleFonts.anybody(
                          color: !isSpecificationSelected
                              ? Colors.white
                              : const Color(0xFF003B8F),
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
          DetailsSection(
            isSpecificationSelected: isSpecificationSelected,
            brand: widget.brand,
            model: widget.model,
            regYear: widget.regYear,
            rearTire: widget.rearTire,
            regNum: widget.regNum,
            insStatus: widget.insStatus,
            oilCap: widget.oilCap,
            fuel: widget.fuel,
            horsePower: widget.horsePower.toString(),
            steeringType: widget.steeringType,
            brake: widget.brake,
            transmission: widget.transmission,
            pto: widget.pto,
            cc: widget.cc,
            liftingCapacity: widget.liftingCapacity,
            cooling: widget.cooling,
          )
        ],
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  final bool isSpecificationSelected;
  final String brand;
  final String model;
  final String regYear;
  final String rearTire;
  final String regNum;
  final String insStatus;
  final String oilCap;
  final String fuel;
  final String horsePower;
  final String steeringType;
  final String brake;
  final String transmission;
  final String pto;
  final String cc;
  final String liftingCapacity;
  final String cooling;

  const DetailsSection({
    super.key,
    required this.isSpecificationSelected,
    required this.brand,
    required this.model,
    required this.regYear,
    required this.rearTire,
    required this.regNum,
    required this.insStatus,
    required this.oilCap,
    required this.fuel,
    required this.horsePower,
    required this.steeringType,
    required this.brake,
    required this.transmission,
    required this.pto,
    required this.cc,
    required this.liftingCapacity,
    required this.cooling,
  });

  @override
  Widget build(BuildContext context) {
    final details = [
      {'label': 'Brand', 'value': brand},
      {'label': 'Model', 'value': model},
      {'label': 'Registration Year', 'value': regYear},
      {'label': 'Rear Tire', 'value': rearTire},
      {'label': 'Registration Number', 'value': regNum},
      {'label': 'Insurance Status', 'value': insStatus},
      {'label': 'Engine Oil Capacity', 'value': oilCap},
      {'label': 'Fuel', 'value': fuel},
    ];

    final features = [
      {'label': 'Horse Power', 'value': horsePower},
      {'label': 'Steering Type', 'value': steeringType},
      {'label': 'Brake', 'value': brake},
      {'label': 'Transmission', 'value': transmission},
      {'label': 'PTO', 'value': pto},
      {'label': 'CC', 'value': cc},
      {'label': 'Lifting Capacity', 'value': liftingCapacity},
      {'label': 'Cooling', 'value': cooling},
    ];

    final dataToShow = isSpecificationSelected ? details : features;

    return Column(
      children: dataToShow.asMap().entries.map((entry) {
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
                style: GoogleFonts.anybody(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                item['value']!,
                style: GoogleFonts.anybody(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
