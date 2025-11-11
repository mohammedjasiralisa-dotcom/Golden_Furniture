import 'package:flutter/material.dart';
import 'my_business.dart';

// Global language code - accessed by all screens
String globalLanguageCode = 'en';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
        backgroundColor: const Color.fromARGB(11, 137, 178, 178),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Please select your preferred language",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // English button
                _buildLanguageButton(context, "English", "en"),
                const SizedBox(height: 15),

                // Tamil button
                _buildLanguageButton(context, "தமிழ்", "ta"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for both buttons
  Widget _buildLanguageButton(BuildContext context, String label, String languageCode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Set the global language code
          globalLanguageCode = languageCode;
          
          // Show a brief confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                languageCode == 'en'
                    ? 'English Selected ✅'
                    : 'தமிழ் தேர்ந்தெடுக்கப்பட்டது ✅',
              ),
              duration: const Duration(milliseconds: 500),
            ),
          );

          // Navigate to My Business screen after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyBusinessScreen()),
            );
          });
        },
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

