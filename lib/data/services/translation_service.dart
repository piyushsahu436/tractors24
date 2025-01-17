//made for apis

import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  // Replace with your actual RapidAPI Key
  static const String apiKey = 'feb45d6887msh87fdfa2a321acbfp1ef655jsn6f335e567e6e';
   //this api key will be changed
  // API Host for Microsoft Translator Text API on RapidAPI
  static const String apiHost = 'microsoft-translator-text-api3.p.rapidapi.com';

  /// Translates the given text from English to Hindi using Microsoft Translator Text API via RapidAPI
  static Future<String> translateText(String text) async {
    try {
      // Make POST request to the RapidAPI Microsoft Translator API
      final response = await http.post(
        Uri.parse('https://$apiHost/translate'),
        headers: {
          'x-rapidapi-key': apiKey,           // Add your RapidAPI Key here
          'x-rapidapi-host': apiHost,         // Add the host URL for the API
          'Content-Type': 'application/json', // Set Content-Type to JSON
        },
        body: jsonEncode({
          'q': text,          // The text you want to translate
          'target': 'hi',     // Target language (Hindi)
          'source': 'en',     // Source language (English)
        }),
      );

      // Check for successful response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract and return the translated text
        return data[0]['translations'][0]['text'];
      } else {
        // If response is not 200, print the error and return the original text
        print('Error: ${response.statusCode} - ${response.body}');
        return text;
      }
    } catch (e) {
      // Catch any exception and print it
      print('Exception occurred during translation: $e');
      return text; // Return the original text in case of an error
    }
  }
}
