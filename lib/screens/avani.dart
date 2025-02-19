import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/Grids/GridViewList.dart';
import "package:tractors24/screens/loanEnquire.dart";
import 'package:tractors24/screens/policies_screen.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage(
      {super.key,
        required this.state,
        required this.description,
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
  final String description;
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 12.0),
                child: Text(
                  'Description :',
                  style: GoogleFonts.anybody(
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
                  style: GoogleFonts.anybody(fontSize: 12, color: Colors.black),
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
                                    style: GoogleFonts.anybody(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Hours",
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
                                    '${Address}',
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
                    // Text('${Address} ',style: GoogleFonts.anybody(fontSize: 25,fontWeight: FontWeight.w500,),textAlign: TextAlign.start, )
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
      // {'label': 'Total Weight', 'value': fuel},
      // {'label': 'Wheel Base', 'value': fuel},
      // {'label': 'Overall Length', 'value': fuel},
      // {'label': 'Overall Width', 'value': fuel},
      // {'label': 'Ground Clearance', 'value': fuel},
      // {'label': 'Front Tyre Size', 'value': fuel},
      // {'label': 'Rear Tyre Size', 'value': fuel},
      // {'label': 'Battery', 'value': fuel},
      // {'label': 'Accessories', 'value': fuel},
      // {'label': 'Warranty', 'value': fuel},
      // {'label': 'Color', 'value': fuel},
      // {'label': 'Pincode', 'value': fuel},
      // {'label': 'Rear Tyre Size', 'value': fuel},
    ];

    final features = [
      {'label': 'Horse Power', 'value': horsePower},
      {'label': 'Steering Type', 'value': steeringType},
      {'label': 'Brake', 'value': brake},
      {'label': 'Transmission', 'value': transmission},
      {'label': 'PTO Horse Power', 'value': pto},
      {'label': 'PTO Directions', 'value': pto},
      {'label': 'CC', 'value': cc},
      {'label': 'Lifting Capacity', 'value': liftingCapacity},
      {'label': 'Cooling System', 'value': cooling},
      //{'label': 'Number of Cylinders', 'value': horsePower},
      // {'label': 'Air Filter', 'value': cooling},
      // {'label': 'Clutch Type', 'value': cooling},
      // {'label': 'Gear Box', 'value': cooling},
      // {'label': 'Forward Speed', 'value': horsePower},
      // {'label': 'RPM', 'value': cooling},
      // {'label': 'Maximum Torque', 'value': cooling},
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
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tractors24/auth/login_page.dart';
// import 'package:tractors24/auth/login_password.dart';

// import 'package:tractors24/screens/policies_screen.dart';
//
// class SignUp1 extends StatefulWidget {
//   const SignUp1({super.key});
//
//   @override
//   State<SignUp1> createState() => _SignUp1();
// }
//
// class _SignUp1 extends State<SignUp1> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String userType = 'Customer';
//   bool isTermsAccepted = false;
//   bool isLoading = false;
//   bool isCustomerSelected = true;
//
//   // void _login(BuildContext context) {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //
//   //   Future.delayed(const Duration(seconds: 2), () {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   });
//   // }
//   Future<void> _signUp() async {
//     if (!formKey.currentState!.validate()) return;
//
//     setState(() => isLoading = true);
//     try {
//       final userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       String? uid = FirebaseAuth.instance.currentUser?.uid;
//
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({
//         'name': nameController.text.trim(),
//         'email': emailController.text.trim(),
//         'phone': phoneController.text.trim(),
//         'userType': userType,
//         'uid': uid,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Sign Up Successful')),
//       );
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => Login2()));
//     } on FirebaseAuthException catch (e) {
//       _showError('Sign up failed: ${e.message}');
//     } catch (e) {
//       _showError(e.toString());
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }
//
//   void _showError(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 Container(
//                   height: size.height * 0.04,
//                   width: size.width * 10,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/Vector_signup.png'),
//                         fit: BoxFit.fill),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.01),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(0.1),
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage('assets/images/Wave.png')),
//                         ),
//                         height: size.width * 0.3,
//                         width: size.width * 0.3,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(0),
//                         child: Text('Sign Up',
//                             style: GoogleFonts.anybody(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w600,
//                               color: const Color(0xFF003B8F),
//                             )),
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: size.height * 0.06,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   // Facebook login will be added later
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Image.asset(
//                                         "assets/images/_Facebook.png",
//                                       ),
//                                       Text(
//                                         'Facebook',
//                                         style: GoogleFonts.anybody(
//                                             fontWeight: FontWeight.w500,
//                                             color: const Color(0xFF61677D)),
//                                       )
//                                     ]),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: size.width * 0.05),
//                           Expanded(
//                             child: Container(
//                               height: size.height * 0.06,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     // Google login will be added later
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Image.asset("assets/images/_Google.png"),
//                                       Text(
//                                         '  Google',
//                                         style: GoogleFonts.anybody(
//                                             fontWeight: FontWeight.w500,
//                                             color: const Color(0xFF61677D)),
//                                       )
//                                     ],
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 15.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Divider(
//                                 color: Colors.grey.shade300, // Line color
//                                 thickness: 1, // Line thickness
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Text('Or',
//                                   style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.w400)),
//                             ),
//                             Expanded(
//                               child: Divider(
//                                 color: Colors.grey.shade300, // Line color
//                                 thickness: 1, // Line thickness
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "I`m a",
//                             style: GoogleFonts.anybody(
//                                 fontSize: 16, fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   isCustomerSelected = true;
//                                   userType = 'Customer';
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 12, horizontal: 30),
//                                 decoration: BoxDecoration(
//                                   color: isCustomerSelected
//                                       ? const Color(0xFF003B8F)
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                       color: const Color(0xFF003B8F), width: 2),
//                                 ),
//                                 child: Text(
//                                   "Customer",
//                                   style: GoogleFonts.poppins(
//                                     color: isCustomerSelected
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   userType = 'Dealer';
//                                   isCustomerSelected = false;
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 12, horizontal: 30),
//                                 decoration: BoxDecoration(
//                                   color: !isCustomerSelected
//                                       ? const Color(0xFF003B8F)
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                       color: const Color(0xFF003B8F), width: 2),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Center(
//                                         child: Text(
//                                           "Dealer",
//                                           style: GoogleFonts.poppins(
//                                             color: !isCustomerSelected
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       SizedBox(height: size.height * 0.01),
//
//                       Form_field(
//                         hintText: "Name",
//                         controller: nameController,
//                         prefixtext: "",
//                         validator: (String? value) {},
//                       ),
//                       SizedBox(height: size.height * 0.001),
//                       Form_field(
//                         hintText: "Email",
//                         controller: emailController,
//                         prefixtext: "",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           } else if (!RegExp(
//                                   r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
//                               .hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: size.height * 0.0001),
//                       Form_field(
//                         hintText: "Phone Number",
//                         controller: phoneController,
//                         prefixtext: "",
//                         validator: (String? value) {},
//                       ),
//                       Form_field(
//                         hintText: "Name ",
//                         controller: nameController,
//                         prefixtext: "First name",
//                         validator: (String? value) {},
//                       ),
//
//                       SizedBox(height: size.height * 0.001),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 3.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black
//                                     .withOpacity(0.1), // Soft shadow
//                                 blurRadius: 10,
//                                 spreadRadius: 2,
//                                 offset:
//                                     const Offset(2, 4), // Slight bottom shadow
//                               ),
//                             ],
//                           ),
//                           child: TextField(
//                             controller: passwordController,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: 'Password',
//                               hintStyle: GoogleFonts.anybody(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 15,
//                                   color:
//                                       const Color.fromRGBO(124, 139, 160, 1.0)),
//                               suffixIcon: const Icon(Icons.visibility_off,
//                                   color: Color(0xFF61677D)),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 16, horizontal: 16),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.001),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 3.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black
//                                     .withOpacity(0.1), // Soft shadow
//                                 blurRadius: 10,
//                                 spreadRadius: 2,
//                                 offset:
//                                     const Offset(2, 4), // Slight bottom shadow
//                               ),
//                             ],
//                           ),
//                           child: TextField(
//                             controller: confirmPasswordController,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               hintText: 'Confirm Password',
//                               hintStyle: GoogleFonts.anybody(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 15,
//                                   color:
//                                       const Color.fromRGBO(124, 139, 160, 1.0)),
//                               suffixIcon: const Icon(Icons.visibility_off,
//                                   color: Color(0xFF61677D)),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 16, horizontal: 16),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.001),
//                       Form_field(
//                         hintText: "Pin Code",
//                         controller: pincodeController,
//                         prefixtext: "",
//                         validator: (String? value) {},
//                       ),
//                       Row(
//                         children: [
//                           Transform.scale(
//                             scale: 1.3,
//                             child: Checkbox(
//                               value: isTermsAccepted,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   isTermsAccepted = value ?? false;
//                                 });
//                               },
//                               splashRadius: 5,
//                               side: const BorderSide(
//                                 color: Color(0xFF003B8F),
//                                 width: 1.0,
//                               ),
//                               activeColor: const Color(
//                                   0xFF003B8F), // Optional: Color when the checkbox is checked
//                               checkColor: Colors.white,
//                             ),
//                           ),
//                           Expanded(
//                             child: RichText(
//                               text: TextSpan(
//                                 style: const TextStyle(color: Colors.black),
//                                 children: [
//                                   TextSpan(
//                                       text: "I'm agree to the ",
//                                       style: GoogleFonts.anybody(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w400)),
//                                   TextSpan(
//                                     text: "Term's of Service",
//                                     style: GoogleFonts.anybody(
//                                       color: const Color(0xFF003B8F),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                       text: " and ",
//                                       style: GoogleFonts.anybody(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w400)),
//                                   TextSpan(
//                                       text: "Privacy Policy",
//                                       style: GoogleFonts.anybody(
//                                         color: const Color(0xFF003B8F),
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 14,
//                                       ),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     PoliciesScreen()),
//                                           );
//                                         }),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Expanded(
//                               child: ElevatedButton(
//                             onPressed: isLoading
//                                 ? null
//                                 : () {
//                                     if (isTermsAccepted &&
//                                         formKey.currentState!.validate()) {
//                                       _signUp(); // Ensure _signUp is defined in your class
//                                     }
//                                   },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF003B8F),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: isLoading
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white)
//                                 : Text(
//                                     'Create Account',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                           )),
//                         ],
//                       ),
//                       SizedBox(height: size.height * 0.001),
//
//                       // Sign up text and button
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Do you have account?",
//                               style: GoogleFonts.anybody(
//                                   fontWeight: FontWeight.w400),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const LoginPage(),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Sign In',
//                                 style: GoogleFonts.anybody(
//                                   color: const Color(0xFF003B8F),
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
