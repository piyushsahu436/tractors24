
 import 'dart:math';
 import 'package:flutter/material.dart';
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              height: 100,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Center(
                  child: Text("EMI Calculator" , style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 18, 7, 29),
              child: Column(
                children: [
                  Text('Loan Amount: ₹${loanAmount.toInt()}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 3, 3, 5),
                    child: Row(
                      children: [
                        const Text('₹1L'),
                        const Spacer(),
                        const Text('₹1Cr'),
                      ],
                    ),
                  ),
                  Text('Tenure: ${tenureInMonths ~/ 12} years',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 3, 3, 5),
                    child: Row(
                      children: [
                        const Text('1 Year'),
                        const Spacer(),
                        const Text('8 Years'),
                      ],
                    ),
                  ),
                  Text('Interest Rate: ${interestRate.toStringAsFixed(1)}%',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 3, 3, 5),
                    child: Row(
                      children: [
                        const Text('5%'),
                        const Spacer(),
                        const Text('16%'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text('EMI Breakdown',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold , color: Colors.blue)),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              Text('Monthly EMI:   ₹${emi.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                           SizedBox(height: 5),
                          Text('Principal Amount:  ₹${loanAmount.toInt()}',
                              style: const TextStyle(fontSize: 14)),
                           SizedBox(height: 5),
                          Text('Interest Amount:  ₹${interestAmount.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 14)),
                           SizedBox(height: 5),
                          Text('Total Payment:  ₹${totalPayment.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 300,
                      child: ElevatedButton(
                        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => LoanInquiryForm()),
    );},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text(
                          'Apply for Loan',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ),

        
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





 class LoanInquiryForm extends StatefulWidget {
   @override
   _LoanInquiryFormState createState() => _LoanInquiryFormState();
 }

 class _LoanInquiryFormState extends State<LoanInquiryForm> {
   int _currentStep = 0;
   final _formKey = GlobalKey<FormState>();

   final _fullNameController = TextEditingController();
   final _mobileController = TextEditingController();
   final _emailController = TextEditingController();
   final _addressController = TextEditingController();
   final _loanAmountController = TextEditingController();
   final _emiController = TextEditingController();
   final _incomeController = TextEditingController();

   // Move to the next step
   void _nextStep() {
     if (_currentStep < 2) {
       setState(() {
         _currentStep++;
       });
     }
   }

   // Go to the previous step
   void _previousStep() {
     if (_currentStep > 0) {
       setState(() {
         _currentStep--;
       });
     }
   }

   // Submit form
   void _submitForm() {
     if (_formKey.currentState!.validate()) {
       // Submit logic
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Inquiry submitted successfully!')),
       );
     }
   }

   @override
   Widget build(BuildContext context) {
     double progress = (_currentStep + 1) / 3;

     return Scaffold(
       appBar: AppBar(title: const Text('Tractor Loan Inquiry')),
       body: Column(
         children: [
           // Horizontal progress indicator
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: LinearProgressIndicator(
               value: progress,
               backgroundColor: Colors.grey[300],
               color: Colors.blue,
             ),
           ),
           Expanded(
             child: Form(
               key: _formKey,
               child: Stepper(
                 type: StepperType.horizontal,
                 currentStep: _currentStep,
                 onStepContinue: _nextStep,
                 onStepCancel: _previousStep,
                 steps: [
                   Step(
                     title: const Text('Personal'),
                     content: Column(
                       children: [
                         TextFormField(
                           controller: _fullNameController,
                           decoration:
                           const InputDecoration(labelText: 'Full Name *'),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter your full name';
                             }
                             return null;
                           },
                         ),
                         TextFormField(
                           controller: _mobileController,
                           decoration: const InputDecoration(
                               labelText: 'Mobile Number *'),
                           keyboardType: TextInputType.phone,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter your mobile number';
                             }
                             return null;
                           },
                         ),
                         TextFormField(
                           controller: _emailController,
                           decoration:
                           const InputDecoration(labelText: 'Email *'),
                           keyboardType: TextInputType.emailAddress,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter your email';
                             }
                             return null;
                           },
                         ),
                         TextFormField(
                           controller: _addressController,
                           decoration:
                           const InputDecoration(labelText: 'Address *'),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter your address';
                             }
                             return null;
                           },
                         ),
                       ],
                     ),
                     isActive: _currentStep >= 0,
                   ),
                   Step(
                     title: const Text('Loan '),
                     content: Column(
                       children: [
                         TextFormField(
                           controller: _loanAmountController,
                           decoration: const InputDecoration(
                               labelText: 'Loan Amount *'),
                           keyboardType: TextInputType.number,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter loan amount';
                             }
                             return null;
                           },
                         ),
                         TextFormField(
                           controller: _emiController,
                           decoration: const InputDecoration(
                               labelText: 'Preferred EMI Amount *'),
                           keyboardType: TextInputType.number,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter preferred EMI amount';
                             }
                             return null;
                           },
                         ),
                         TextFormField(
                           controller: _incomeController,
                           decoration: const InputDecoration(
                               labelText: 'Annual Income *'),
                           keyboardType: TextInputType.number,
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Please enter your annual income';
                             }
                             return null;
                           },
                         ),
                       ],
                     ),
                     isActive: _currentStep >= 1,
                   ),
                   Step(
                     title: const Text('Tractors'),
                     content: Column(
                       children: [
                         DropdownButtonFormField<String>(
                           decoration: const InputDecoration(
                               labelText: 'Tractor Model *'),
                           items: const [
                             DropdownMenuItem(
                                 value: 'Model A', child: Text('Model A')),
                             DropdownMenuItem(
                                 value: 'Model B', child: Text('Model B')),
                           ],
                           onChanged: (value) {},
                         ),
                         DropdownButtonFormField<String>(
                           decoration: const InputDecoration(
                               labelText: 'Year of Manufacture *'),
                           items: List.generate(
                             20,
                                 (index) => DropdownMenuItem(
                               value: (2000 + index).toString(),
                               child: Text((2000 + index).toString()),
                             ),
                           ),
                           onChanged: (value) {},
                         ),
                       ],
                     ),
                     isActive: _currentStep >= 2,
                   ),
                 ],
                 controlsBuilder: (BuildContext context, ControlsDetails details) {
                   return Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       if (_currentStep > 0)
                         ElevatedButton(
                           onPressed: details.onStepCancel,
                           child: const Text('Back'),
                         ),
                       if (_currentStep < 2)
                         ElevatedButton(
                           onPressed: details.onStepContinue,
                           child: const Text('Next'),
                         ),
                       if (_currentStep == 2)
                         ElevatedButton(
                           onPressed: _submitForm,
                           child: const Text('Submit Inquiry'),
                         ),
                     ],
                   );
                 },
               ),
             ),
           ),
         ],
       ),
     );
   }
 }




