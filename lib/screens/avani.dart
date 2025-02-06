//
//
//
//
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:tractors24/screens/loanEnquire.dart';
// class EMICalculatorScreen extends StatefulWidget {
//   const EMICalculatorScreen({super.key});
//
//   @override
//   _EMICalculatorScreenState createState() => _EMICalculatorScreenState();
// }
//
//
// class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
//   double loanAmount = 500000;
//   int tenureInMonths = 60;
//   double interestRate = 10.5;
//
//   double calculateEMI() {
//     double monthlyRate = interestRate / (12 * 100);
//     double emi = (loanAmount * monthlyRate * pow(1 + monthlyRate, tenureInMonths)) /
//         (pow(1 + monthlyRate, tenureInMonths) - 1);
//     return emi;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double emi = calculateEMI();
//     double totalPayment = emi * tenureInMonths;
//     double interestAmount = totalPayment - loanAmount;
//
//     return Scaffold(
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//               ),
//               height: 100,
//               width: MediaQuery.sizeOf(context).width,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 45),
//                 child: Center(
//                   child: Text("EMI Calculator" , style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.white,
//                   ),),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(5, 18, 7, 29),
//               child: Column(
//                 children: [
//                   Text('Loan Amount: ₹${loanAmount.toInt()}',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Slider(
//                     value: loanAmount,
//                     min: 100000,
//                     max: 10000000,
//                     divisions: 100,
//                     label: loanAmount.toInt().toString(),
//                     onChanged: (value) {
//                       setState(() {
//                         loanAmount = value;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 3, 3, 5),
//                     child: Row(
//                       children: [
//                         const Text('₹1L'),
//                         const Spacer(),
//                         const Text('₹1Cr'),
//                       ],
//                     ),
//                   ),
//                   Text('Tenure: ${tenureInMonths ~/ 12} years',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Slider(
//                     value: tenureInMonths.toDouble(),
//                     min: 12,
//                     max: 96,
//                     divisions: 7,
//                     label: '${tenureInMonths ~/ 12} years',
//                     onChanged: (value) {
//                       setState(() {
//                         tenureInMonths = value.toInt();
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 3, 3, 5),
//                     child: Row(
//                       children: [
//                         const Text('1 Year'),
//                         const Spacer(),
//                         const Text('8 Years'),
//                       ],
//                     ),
//                   ),
//                   Text('Interest Rate: ${interestRate.toStringAsFixed(1)}%',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Slider(
//                     value: interestRate,
//                     min: 5,
//                     max: 16,
//                     divisions: 11,
//                     label: '${interestRate.toStringAsFixed(1)}%',
//                     onChanged: (value) {
//                       setState(() {
//                         interestRate = value;
//                       });
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 3, 3, 5),
//                     child: Row(
//                       children: [
//                         const Text('5%'),
//                         const Spacer(),
//                         const Text('16%'),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text('EMI Breakdown',
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold , color: Colors.blue)),
//                           ),
//                           const SizedBox(height: 10),
//                           Column(
//                             children: [
//                               Text('Monthly EMI:   ₹${emi.toStringAsFixed(2)}',
//                                   style: const TextStyle(fontSize: 14)),
//                             ],
//                           ),
//                           SizedBox(height: 5),
//                           Text('Principal Amount:  ₹${loanAmount.toInt()}',
//                               style: const TextStyle(fontSize: 14)),
//                           SizedBox(height: 5),
//                           Text('Interest Amount:  ₹${interestAmount.toStringAsFixed(2)}',
//                               style: const TextStyle(fontSize: 14)),
//                           SizedBox(height: 5),
//                           Text('Total Payment:  ₹${totalPayment.toStringAsFixed(2)}',
//                               style: const TextStyle(fontSize: 14)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   SizedBox(
//                       width: 300,
//                       child: ElevatedButton(
//                         onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Loanenquire()),
//                         );},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.teal,
//                         ),
//                         child: const Text(
//                           'Apply for Loan',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //
// SliderTheme(
// data: SliderThemeData(
// activeTrackColor: Colors.blue[900],
// inactiveTrackColor: Colors.grey[300],
// thumbColor: Colors.blue[900],
// trackHeight: 8.0,
// thumbShape: const RoundSliderThumbShape(
// enabledThumbRadius: 8.0,
// ),
// overlayShape: SliderComponentShape.noOverlay,
// tickMarkShape: RoundSliderTickMarkShape(
// tickMarkRadius: 1.0,
// ),
// activeTickMarkColor: Colors.blue[900],
// inactiveTickMarkColor: Colors.grey[300],
// valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
// valueIndicatorColor: Colors.blue[900],
// valueIndicatorTextStyle: const TextStyle(
// color: Colors.white,
// ),
// ),