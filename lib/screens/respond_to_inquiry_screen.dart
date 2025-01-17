import 'package:flutter/material.dart';

class RespondToInquiryScreen extends StatefulWidget {
  const RespondToInquiryScreen({super.key});

  @override
  State<RespondToInquiryScreen> createState() => _RespondToInquiryScreenState();
}

class _RespondToInquiryScreenState extends State<RespondToInquiryScreen> {
  final TextEditingController _responseController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_responseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your response'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Here send the response to your backend



      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.pop(context, _responseController.text);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending response: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respond to Inquiry'),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _responseController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type your response here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Text('Send Response'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}