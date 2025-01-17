// faq_screen.dart

import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
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
          'answer': 'Showroom details can be found in the Showrooms section of the website.'
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: _buildFAQList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 24,
              //fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
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
      padding: EdgeInsets.all(16),
      itemCount: faqData.length,
      itemBuilder: (context, sectionIndex) {
        return Card(
          margin: EdgeInsets.only(bottom: 16),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
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
              style: TextStyle(
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
      physics: NeverScrollableScrollPhysics(),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              expandedQuestionIndex == questionIndex
                  ? Icons.remove
                  : Icons.add,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerTile(int sectionIndex, int questionIndex) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFFBBDEFB),
      child: Text(
        faqData[sectionIndex]['questions'][questionIndex]['answer'],
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}