import 'package:flutter/material.dart';
import 'package:tractors24/auth/sign_up.dart';
import 'package:tractors24/screens/buyer_page.dart';
import 'package:tractors24/screens/homepage.dart';
import 'package:tractors24/data/services/translation_service.dart';
import 'package:tractors24/data/repositories/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isHindi = false;
  Map<String, String> translations = {
    'Welcome Back!': 'Welcome Back!',
    'Email Address': 'Email Address',
    'Password': 'Password',
    'Login': 'Login',
    "Don't have an account? Sign Up": "Don't have an account? Sign Up",
  };

  Future<void> translateAllTexts() async {
    if (isHindi) {
      Map<String, String> newTranslations = {};
      for (String key in translations.keys) {
        String translatedText = await TranslationService.translateText(key);
        newTranslations[key] = translatedText;
      }
      setState(() => translations = newTranslations);
    } else {
      setState(() => translations = {
        'Welcome Back!': 'Welcome Back!',
        'Email Address': 'Email Address',
        'Password': 'Password',
        'Login': 'Login',
        "Don't have an account? Sign Up": "Don't have an account? Sign Up",
      });
    }
  }

  Future<void> _login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      final result = await _authService.loginUser(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted) return;

      if (result['success']) {
        final route = MaterialPageRoute(
          builder: (_) => result['userType'] == 'Customer'
              ? BuyerScreen()
              : HomePage(),
        );
        Navigator.pushReplacement(context, route);
      } else {
        _showError(result['message']);
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () async {
              String? selectedLanguage = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Choose Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('English'),
                          onTap: () => Navigator.pop(context, 'en'),
                        ),
                        ListTile(
                          title: Text('Hindi'),
                          onTap: () => Navigator.pop(context, 'hi'),
                        ),
                      ],
                    ),
                  );
                },
              );

              if (selectedLanguage != null) {
                setState(() => isHindi = selectedLanguage == 'hi');
                await translateAllTexts();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isHindi ? "Switched to Hindi" : "Switched to English",
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/banner1.jpg',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                translations['Welcome Back!']!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: translations['Email Address'],
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your email';
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: translations['Password'],
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                obscureText: true,
                validator: (value) => (value?.isEmpty ?? true)
                    ? 'Please enter your password'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                  translations['Login']!,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpPage()),
                ),
                child: Text(translations["Don't have an account? Sign Up"]!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}