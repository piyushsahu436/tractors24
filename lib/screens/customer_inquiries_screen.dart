import 'package:flutter/material.dart';
import 'package:tractors24/screens/respond_to_inquiry_screen.dart';

class CustomerInquiriesScreen extends StatefulWidget {
  const CustomerInquiriesScreen({super.key});

  @override
  State<CustomerInquiriesScreen> createState() => _CustomerInquiriesScreenState();
}

class _CustomerInquiriesScreenState extends State<CustomerInquiriesScreen> {
  int _selectedIndex = 0;
  final List<String> _tabs = ['All Enquiries', 'Pending', 'Responded', 'Closed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Enquiries'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              children: List.generate(
                _tabs.length,
                    (index) => Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedIndex == index
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        _tabs[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                          _selectedIndex == index ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Inquiry Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                InquiryCard(
                  email: 'aj@gmail.com',
                  message: 'demo',
                  onRespond: () => _showRespondScreen(context),
                ),
                const SizedBox(height: 16),
                InquiryCard(
                  email: 'aj13@gmail.com',
                  message: 'demo',
                  onRespond: () => _showRespondScreen(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRespondScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RespondToInquiryScreen(),
      ),
    );
  }
}

class InquiryCard extends StatelessWidget {
  final String email;
  final String message;
  final VoidCallback onRespond;

  const InquiryCard({
    super.key,
    required this.email,
    required this.message,
    required this.onRespond,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.email, size: 20),
                    const SizedBox(width: 8),
                    Text(email),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 8),
                Text('Invalid Date'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.message, size: 20),
                const SizedBox(width: 8),
                Text(message),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRespond,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Respond'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}