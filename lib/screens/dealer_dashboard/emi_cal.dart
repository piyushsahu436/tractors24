import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractors24/screens/loanEnquire.dart';

class EMICalculatorScreen extends StatefulWidget {
  const EMICalculatorScreen({super.key});

  @override
  _EMICalculatorScreenState createState() => _EMICalculatorScreenState();
}

class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
  double loanAmount = 500000;
  int tenureInMonths = 60;
  double interestRate = 10.5;

  double calculateEMI() {
    double monthlyRate = interestRate / (12 * 100);
    double emi =
        (loanAmount * monthlyRate * pow(1 + monthlyRate, tenureInMonths)) /
            (pow(1 + monthlyRate, tenureInMonths) - 1);
    return emi;
  }

  Widget _buildTickLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double emi = calculateEMI();
    double totalPayment = emi * tenureInMonths;
    double interestAmount = totalPayment - loanAmount;

    return Scaffold(
     // backgroundColor: Colors.blue[900],
      body: Column(
        children: [
          // Header with back button
          Container(
            padding: const EdgeInsets.all(16.0),
            height: 150,
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage('assets/images/Vector4.png'),
             fit: BoxFit.fill
             ),

           ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: const Text(
                    "EMI Calculator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 24,)
              ],
            ),
          ),

          // Main Content Card
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Loan Amount Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Loan Amount',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹ ${loanAmount.toInt()}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '₹',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Loan Amount Slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8.0,
                        activeTrackColor: Colors.blue[900],
                        inactiveTrackColor: Colors.grey[300],
                        thumbColor: Colors.blue[900],
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius:
                                10.0), // Increases the thumb size
                        overlayShape: SliderComponentShape.noOverlay,
                        tickMarkShape: RoundSliderTickMarkShape(
                          tickMarkRadius: 1.0,
                        ),
                        activeTickMarkColor: Colors.blue[900],
                        inactiveTickMarkColor: Colors.grey[300],
                        valueIndicatorShape:
                            const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.blue[900],
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        value: loanAmount,
                        min: 100000,
                        max: 600000,
                        divisions: 100,
                        label: loanAmount.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            loanAmount = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTickLabel('1 lakh'),
                          _buildTickLabel('2 lakh'),
                          _buildTickLabel('3 lakh'),
                          _buildTickLabel('4 lakh'),
                          _buildTickLabel('5 lakh'),
                          _buildTickLabel('6 lakh'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tenure Section
                    Text(
                      'Tenure',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${tenureInMonths ~/ 12} Year',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tenure Slider
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.blue[900],
                        inactiveTrackColor: Colors.grey[300],
                        thumbColor: Colors.blue[900],
                        trackHeight: 8.0,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8.0,
                        ),
                        overlayShape: SliderComponentShape.noOverlay,
                        tickMarkShape: RoundSliderTickMarkShape(
                          tickMarkRadius: 4.0,
                        ),
                        activeTickMarkColor: Colors.blue[900],
                        inactiveTickMarkColor: Colors.grey[300],
                        valueIndicatorShape:
                            const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.blue[900],
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        children: [
                          Slider(
                            value: tenureInMonths.toDouble(),
                            min: 12,
                            max: 72,
                            divisions: 5,
                            label: '${tenureInMonths ~/ 12} years',
                            onChanged: (value) {
                              setState(() {
                                tenureInMonths = value.toInt();
                              });
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTickLabel('1 Year'),
                                _buildTickLabel('2 Year'),
                                _buildTickLabel('3 Year'),
                                _buildTickLabel('4 Year'),
                                _buildTickLabel('5 Year'),
                                _buildTickLabel('6 Year'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Interest Rate Section
                    Text(
                      'Interest Rate',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${interestRate.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Interest Rate Slider
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.blue[900],
                        inactiveTrackColor: Colors.grey[300],
                        thumbColor: Colors.blue[900],
                        trackHeight: 8.0,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8.0,
                        ),
                        overlayShape: SliderComponentShape.noOverlay,
                        tickMarkShape: RoundSliderTickMarkShape(
                          tickMarkRadius: 1.0,
                        ),
                        activeTickMarkColor: Colors.blue[900],
                        inactiveTickMarkColor: Colors.grey[300],
                        valueIndicatorShape:
                            const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.blue[900],
                        valueIndicatorTextStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Column(
                        children: [
                          Slider(
                            value: interestRate,
                            min: 5,
                            max: 15,
                            divisions: 10,
                            label: '${interestRate.toStringAsFixed(1)}%',
                            onChanged: (value) {
                              setState(() {
                                interestRate = value;
                              });
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTickLabel('5%'),
                                _buildTickLabel('7%'),
                                _buildTickLabel('9%'),
                                _buildTickLabel('11%'),
                                _buildTickLabel('13%'),
                                _buildTickLabel('15%'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // EMI Breakdown Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(2, 4)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EMI Breakdown',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildBreakdownRow('Monthly EMI', emi),
                          _buildBreakdownRow('Principle Amount', loanAmount),
                          _buildBreakdownRow('Interest Amount', interestAmount),
                          Divider(height: 10,color: Colors.black26),
                          _buildBreakdownRow('Total Amount', totalPayment,
                              isBold: true),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Apply For Loan Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loanenquire()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Apply For Loan',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, double amount,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹ ${amount.toStringAsFixed(2)}',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
