import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Vector3.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 39), // Add space from top for status bar
                     headerTemp(text: 'Privacy Policies',),
                    Expanded(
                      child: Center(
                        child: Image(
                          image: const AssetImage('assets/images/img.png'),
                          width: size.width * 0.8,
                          height: size.height * 0.8,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
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
                      //  _buildPolicySection(title, description, points)
                    ],
                  ),
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
        Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        if (description.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.poppins(
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
                  Text(
                    '• ',
                    style: GoogleFonts.poppins(
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

class headerTemp extends StatelessWidget {
   headerTemp({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/rect.png"),scale: 1)),
            child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ), // Space between icon and text
        Expanded(
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
