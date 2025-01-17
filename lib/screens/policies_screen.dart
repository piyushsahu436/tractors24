import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Privacy Policies',
            style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,
            fontSize: 18.0),
          ),
          backgroundColor: Colors.white,
          elevation: 0, // Removes shadow for a clean look
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Blue line with company name
            Container(
              color: Colors.blue[900], // Blue background color
              padding: const EdgeInsets.all(8.0), // Padding around text
              child: const Text(
                '     Tractors 24',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 20, // Font size
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            Container(
              color: Colors.blue, // Blue background color
              padding: const EdgeInsets.all(30.0), // Padding around text
              alignment: Alignment.center, // Center-aligns the text
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold,
                  fontSize: 28, // Font size
                ),
              ),
            ),
            // Content with scrolling
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPolicySection(
                      'User Data Policy',
                      'We value your privacy and are committed to protecting your personal data. This Privacy Policy outlines the types of information we collect, how we use it, and your rights regarding that information.',
                      [
                        'Data Collection: We collect personal information such as your name, email address, and phone number for account creation and service improvement.',
                        'Data Usage: Your data will be used to personalize your experience, send notifications, and improve our services. We do not sell or share your data with third parties without your consent.',
                        'Data Security: We use industry-standard security measures to protect your data from unauthorized access.',
                        'Your Rights: You have the right to access, modify, or delete your personal data at any time. Contact us for assistance with any of these requests.',
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildPolicySection(
                      'Terms of Service',
                      'By using our services, you agree to abide by the following terms and conditions:',
                      [
                        'User Responsibilities: You agree to use the platform for lawful purposes only. Any violation of this agreement may result in account termination.',
                        'Account Security: You are responsible for maintaining the confidentiality of your account details and for all activities under your account.',
                        'Service Availability: We strive to provide uninterrupted service, but we do not guarantee that our platform will always be available or error-free.',
                        'Modifications: We reserve the right to update or modify the terms of service at any time. You will be notified of any significant changes.',
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildPolicySection(
                      'Refund & Cancellation Policy',
                      '',
                      [
                        'Refund Eligibility: Refunds are eligible only if the service is not delivered as promised or if there was an error on our part.',
                        'Cancellation: You may cancel services at any time before delivery. After that, cancellations will not be processed.',
                        'Processing Time: Refund requests will be processed within 10 business days after review.',
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildPolicySection(
                      'Cookie Policy',
                      'We use cookies to enhance user experience, analyze website traffic, and serve personalized advertisements. By using our services, you agree to our use of cookies.',
                      [
                        'What are Cookies?: Cookies are small text files stored on your device to remember your preferences and enhance your browsing experience.',
                        'How We Use Cookies: We use cookies to remember your login details, track your preferences, and analyze site traffic to improve our services.',
                        'Managing Cookies: You can manage your cookie preferences through your browser settings. However, disabling cookies may affect some functionality of our website.',
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildPolicySection(
                      'Terms for Service Providers',
                      '',
                      [
                        'Service Agreement: All service providers are required to enter into a service agreement that outlines the scope of work, compensation, and timelines.',
                        'Service Standards: Service providers must meet the agreed-upon service standards and comply with all applicable laws and regulations.',
                        'Non-Compete: Service providers may not engage in activities that directly compete with the services offered by our platform during the course of the agreement.',
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(
      String title, String description, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (description.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
        const SizedBox(height: 16),
        ...points.map((point) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
