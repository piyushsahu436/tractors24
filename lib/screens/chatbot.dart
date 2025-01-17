// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:flutter/material.dart';
//
// const apiKey = 'AIzaSyA447xoi2rrPmaLnWc8mNwgY4NNkvdFxDM'; // Recommended: Set the API key in your environment variables and access it e.g., final apiKey = Platform.environment['API_KEY'];
//
// final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
//
// final TextEditingController _userPrompt = TextEditingController();
// final List<Message> _messages = [];
//
// class Message {
//   final String message; // Make it final if it shouldn't change
//
//   Message({required this.message});
// }
//
// Future<void> sendPrompt() async {
//   final message = _userPrompt.text;
//   _userPrompt.clear();
//
//   setState(() {
//     _messages.add(Message(message: message));
//   });
//
//   final prompt = [Content.text(message)];
//   final response = await model.generateContent(prompt);
//
//   setState(() {
//     _messages.add(Message(message: response.text ?? ''));
//   });
// }
//
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _userMessage = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(
//             child: ListView.builder(  // List view to display the entire chat
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final msg = _messages[index];
//                 return Messages(
//                   message: msg.message,
//                 );
//               },
//             ),
//           ),
//           Padding( // TextFormField to type in user prompt
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _userMessage,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                       label: const Text('Chat with Gemini'),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: sendPrompt, // function to call the API with user prompt
//                   padding: const EdgeInsets.all(15),
//                   icon: const Icon(Icons.send),
//                   iconSize: 30,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
