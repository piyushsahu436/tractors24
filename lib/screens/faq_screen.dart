import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

    int? expandedSectionIndex;
  int? expandedQuestionIndex;

  // FAQ Data
  final List<Map<String, dynamic>> faqData = [
    {
      'title': 'For Buyers',
      'questions': [
        {
          'question': 'How can I change the language of the platform?',
          'answer':
          'You can change the language by navigating to the settings menu and selecting your preferred language from the available options.'
        },
        {
          'question': 'Is this website available in regional languages?',
          'answer':
          'Yes, the platform supports multiple languages to cater to a diverse user base.'
        },
        {
          'question': 'How do I log in to my account?',
          'answer':
          'To log in, click on the Login button on the homepage and enter your credentials. If you encounter any issues, please check your username and password.'
        },
        {
          'question': 'What should I do if I forgot my password?',
          'answer':
          'If you forgot your password, click on the Forgot Password? link on the login page and follow the instructions to reset it.'
        },
        {
          'question': 'How do I search for tractors near me?',
          'answer':
          'You can use the advanced search options to filter listings based on your location, including state, city, and district.'
        },
      ]
    },
    {
      'title': 'For Sellers',
      'questions': [
        {
          'question': 'How can I post a tractor for sale?',
          'answer':
          'You can post a tractor for sale by accessing the seller dashboard and filling out the listing form with the necessary details.'
        },
        {
          'question': 'What filters are available for searching tractors?',
          'answer':
          'You can filter listings by various criteria, including location, price range, and tractor specifications.'
        },
        {
          'question': 'How does the referral system work?',
          'answer':
          'You can earn rewards by referring others to the platform. Once they sign up and complete a transaction, you will receive your rewards.'
        },
      ]
    },
    {
      'title': 'For Dealers',
      'questions': [
        {
          'question': 'How can a dealer create an account?',
          'answer':
          'Dealers can create an account by filling out the registration form available on the dealer login portal.'
        },
        {
          'question': 'What are the benefits of the dealer login portal?',
          'answer':
          'The dealer login portal allows you to post listings, view customer details, and manage your margins effectively.'
        },
        {
          'question': 'Where can I find showroom details?',
          'answer':
          'Showroom details can be found in the Showrooms section of the website.'
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Vector3.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 39), // Add space from top for status bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 115), // Space between icon and text
                      Text(
                        'FAQ`S',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/img.png'),
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

          _buildHeader(),
          Container(
            child: Expanded(

              child: _buildFAQList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'We are here to help you',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Questions commonly asked by Buyers and Sellers',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqData.length,
      itemBuilder: (context, sectionIndex) {
        return Card(
          margin: const EdgeInsets.only(bottom: 35),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSectionHeader(sectionIndex),
              if (expandedSectionIndex == sectionIndex)
                _buildQuestionsList(sectionIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(int sectionIndex) {
    return InkWell(
      onTap: () {
        setState(() {
          if (expandedSectionIndex == sectionIndex) {
            expandedSectionIndex = null;
          } else {
            expandedSectionIndex = sectionIndex;
          }
          expandedQuestionIndex = null;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(12),
            bottom: Radius.circular(
              expandedSectionIndex == sectionIndex ? 0 : 12,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              faqData[sectionIndex]['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              expandedSectionIndex == sectionIndex
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsList(int sectionIndex) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqData[sectionIndex]['questions'].length,
      itemBuilder: (context, questionIndex) {
        return Column(
          children: [
            _buildQuestionTile(sectionIndex, questionIndex),
            if (expandedQuestionIndex == questionIndex)
              _buildAnswerTile(sectionIndex, questionIndex),
          ],
        );
      },
    );
  }

  Widget _buildQuestionTile(int sectionIndex, int questionIndex) {
    return InkWell(
      onTap: () {
        setState(() {
          if (expandedQuestionIndex == questionIndex) {
            expandedQuestionIndex = null;
          } else {
            expandedQuestionIndex = questionIndex;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFFE3F2FD),
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                faqData[sectionIndex]['questions'][questionIndex]['question'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              expandedQuestionIndex == questionIndex ? Icons.remove : Icons.add,
              color: Color(0xFF003B8F),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerTile(int sectionIndex, int questionIndex) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFBBDEFB),
      child: Text(
        faqData[sectionIndex]['questions'][questionIndex]['answer'],
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}