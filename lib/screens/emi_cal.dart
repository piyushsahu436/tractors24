import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tractors24/screens/loanEnquire.dart';



class EMICalculatorScreen extends StatefulWidget {
  @override
  _EMICalculatorScreenState createState() => _EMICalculatorScreenState();
}


class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
  double loanAmount = 500000;
  int tenureInMonths = 60;
  double interestRate = 10.5;

  double calculateEMI() {
    double monthlyRate = interestRate / (12 * 100);
    double emi = (loanAmount * monthlyRate * pow(1 + monthlyRate, tenureInMonths)) /
        (pow(1 + monthlyRate, tenureInMonths) - 1);
    return emi;
  }

  @override
  Widget build(BuildContext context) {
    double emi = calculateEMI();
    double totalPayment = emi * tenureInMonths;
    double interestAmount = totalPayment - loanAmount;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 26, 7, 29),
        child: Column(
          children: [
            Text('Loan Amount: ₹${loanAmount.toInt()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: loanAmount,
              min: 100000,
              max: 10000000,
              divisions: 100,
              label: loanAmount.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  loanAmount = value;
                });
              },
            ),
            Text('Tenure: ${tenureInMonths ~/ 12} years',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: tenureInMonths.toDouble(),
              min: 12,
              max: 96,
              divisions: 7,
              label: '${tenureInMonths ~/ 12} years',
              onChanged: (value) {
                setState(() {
                  tenureInMonths = value.toInt();
                });
              },
            ),
            Text('Interest Rate: ${interestRate.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: interestRate,
              min: 5,
              max: 16,
              divisions: 11,
              label: '${interestRate.toStringAsFixed(1)}%',
              onChanged: (value) {
                setState(() {
                  interestRate = value;
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EMI Breakdown',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Monthly EMI: ₹${emi.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('Principal Amount: ₹${loanAmount.toInt()}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('Interest Amount: ₹${interestAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('Total Payment: ₹${totalPayment.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 300, // Set the desired width
              child: ElevatedButton(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=> Loanenquire()));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Apply for Loan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



