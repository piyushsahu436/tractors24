import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import 'package:tractors24/screens/contact_seller.dart';
import "package:tractors24/screens/loanEnquire.dart";
import 'package:tractors24/screens/policies_screen.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage(
      {super.key,
      required this.Pincode,
      required this.state,
      required this.description,
      required this.SellPrice,
      required this.brand,
      required this.model,
      required this.RegYear,
      required this.HorsePower,
      required this.Hours,
      required this.RegNum,
      required this.InsStatus,
      required this.RearTire,
      required this.Address,
      required this.Break,
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
      required this.safetyfeature,
      required this.warrenty,
      required this.color,
      required this.accessories,
      required this.rpm,
      required this.ptodirection,
      required this.battery,
      required this.gearbox,
      required this.cylinder,
      required this.torque,
      this.imageUrls,
      required this.fronttyre,
      required this.pincode,
      required this.clutch,
      required this.docId});
  final String torque;
  final String clutch;
  final String cylinder;
  final String gearbox;
  final String battery;
  final String ptodirection;
  final String rpm;
  final String accessories;
  final String color;
  final String warrenty;
  final String safetyfeature;
  final String SellPrice;
  final String state;
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
  final String PTO;
  final String CC;
  final String Cooling;
  final String LiftingCapacity;
  final String SteeringType;
  final String ClutchType;
  final String OilCap;
  final String RunningKM;
  final String Fuel;
  final String pincode;
  final String description;
  final List<String>? imageUrls;
  final String fronttyre;
  final String docId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003B8F),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactSellerScreen(
                      imageUrls: imageUrls,
                      docid: docId,
                      brand: brand,
                      price: SellPrice,
                      location: Address,
                      model: model,
                    ),
                  ));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              side: const BorderSide(color: Color(0xFF003B8F), width: 1.5),
              backgroundColor: const Color(0xFF003B8F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Contact Seller',
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        '${brand} ${model}',
                        style: GoogleFonts.roboto(
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 12.0),
                child: Text(
                  'Description :',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Color(0xFF003B8F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                child: Text(
                  '${description}',
                  style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
                ),
              ),
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
                                      Icons.watch_later_outlined,
                                      color: Colors.black,
                                      size: 24.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    '${Hours}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Hours",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
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
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Model",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
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
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Fuel Type",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
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
                                    '${Address}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Location",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
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
                            style: GoogleFonts.roboto(
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
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ]),
                    // Text('${Address} ',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.w500,),textAlign: TextAlign.start, )
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
                pto: PTO,
                cc: CC,
                liftingCapacity: LiftingCapacity,
                cooling: Cooling,
                fronttyre: fronttyre,
                accessories: accessories,
                warranty: warrenty,
                color: color,
                pincode: pincode,
                safetyfeature: '',
                clutch: clutch,
                gear: gearbox,
                rpm: rpm,
                torque: torque, ptodire: ptodirection, battery: battery,
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
  const TabBarSection({
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
    required this.pto,
    required this.cc,
    required this.liftingCapacity,
    required this.cooling,
    required this.fronttyre,
    required this.accessories,
    required this.warranty,
    required this.color,
    required this.pincode,
    required this.safetyfeature,
    required this.clutch,
    required this.gear,
    required this.rpm,
    required this.torque,
    required this.ptodire,
    required this.battery,
  });
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
  final String pto;
  final String cc;
  final String liftingCapacity;
  final String cooling;
  final String battery;
  final String fronttyre;
  final String accessories;
  final String warranty;
  final String color;
  final String pincode;
  final String safetyfeature;
  final String clutch;
  final String gear;
  final String rpm;
  final String torque;
  final String ptodire;

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
                        style: GoogleFonts.roboto(
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
                        style: GoogleFonts.roboto(
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
            pto: widget.pto,
            cc: widget.cc,
            liftingCapacity: widget.liftingCapacity,
            cooling: widget.cooling,
            battery: widget.battery,
            fronttyre: widget.fronttyre,
            accessories: widget.accessories,
            warranty: widget.warranty,
            color: widget.color,
            pincode: widget.pincode,
            safetyfeature: widget.safetyfeature,
            clutch: widget.clutch,
            gear: widget.gear,
            rpm: widget.rpm,
            torque: widget.torque,
            ptodire: widget.ptodire,
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
  final String pto;
  final String cc;
  final String liftingCapacity;
  final String cooling;
  final String battery;
  final String fronttyre;
  final String accessories;
  final String warranty;
  final String color;
  final String pincode;
  final String safetyfeature;
  final String clutch;
  final String gear;
  final String rpm;
  final String torque;
  final String ptodire;

  const DetailsSection({
    super.key,
    required this.battery,
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
    required this.pto,
    required this.cc,
    required this.liftingCapacity,
    required this.cooling,
    required this.fronttyre,
    required this.accessories,
    required this.warranty,
    required this.color,
    required this.pincode,
    required this.safetyfeature,
    required this.clutch,
    required this.gear,
    required this.rpm,
    required this.torque,
    required this.ptodire,
  });

  @override
  Widget build(BuildContext context) {
    final details = [
      {'label': 'Brand', 'value': brand},
      {'label': 'Model', 'value': model},
      {'label': 'Registration Year', 'value': regYear},
      {'label': 'Registration Number', 'value': regNum},
      {'label': 'Insurance Status', 'value': insStatus},
      {'label': 'Fuel Tank', 'value': oilCap},
      {'label': 'Fuel Type', 'value': fuel},
      {'label': 'Front Tyre ', 'value': fronttyre},
      {'label': 'Rear Tyre ', 'value': rearTire},
      {'label': 'Battery', 'value': battery},
      {'label': 'Accessories', 'value': accessories},
      {'label': 'Warranty', 'value': warranty},
      {'label': 'Color', 'value': color},
      {'label': 'Pincode', 'value': pincode},
      {'label': 'Safety Feature', 'value': safetyfeature},
    ];

    final features = [
      {'label': 'Horse Power', 'value': horsePower},
      {'label': 'Steering Type', 'value': steeringType},
      {'label': 'Brake', 'value': brake},
      {'label': 'PTO Horse Power', 'value': pto},
      {'label': 'PTO Directions', 'value': ptodire},
      {'label': 'Capacity (CC)', 'value': cc},
      {'label': 'Lifting Capacity', 'value': liftingCapacity},
      {'label': 'Cooling System', 'value': cooling},
      {'label': 'Number of Cylinders', 'value': horsePower},
      {'label': 'Clutch Type', 'value': clutch},
      {'label': 'Gear Box', 'value': gear},
      {'label': 'RPM', 'value': rpm},
      {'label': 'Maximum Torque', 'value': torque},
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
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                item['value']!,
                style: GoogleFonts.roboto(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
