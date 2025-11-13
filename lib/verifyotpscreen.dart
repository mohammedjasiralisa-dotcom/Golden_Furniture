import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'language.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool otpSent = false;
  String? generatedOtp;
  DateTime? otpGeneratedTime;

  String generateOtp() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  void sendOtp() {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }
    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone number must be 10 digits")),
      );
      return;
    }

    generatedOtp = generateOtp();
    otpGeneratedTime = DateTime.now();

    String message =
        "Welcome to Golden Furniture!\nYour OTP for login is $generatedOtp.\nIt is valid for 10 minutes.";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "📩 SMS Message",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "From: Golden Furniture\nTo: +91 $phone\n\n$message",
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    setState(() {
      otpSent = true;
    });
  }

  void verifyOtp() {
    if (generatedOtp == null || otpGeneratedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please send OTP first")),
      );
      return;
    }

    final now = DateTime.now();
    final difference = now.difference(otpGeneratedTime!);
    if (difference.inMinutes >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP expired ❌ Please request a new one."),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        otpSent = false;
      });
      return;
    }

    if (otpController.text.trim() == generatedOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Welcome ${nameController.text}! OTP Verified Successfully 🎉"),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LanguageScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP ❌"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.black);
            },
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to the Golden Furniture",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Name field
                    TextField(
                      controller: nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: "Enter Name",
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Phone field
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        prefixText: "+91 ",
                        prefixStyle: const TextStyle(color: Colors.black),
                        labelText: "Enter Mobile Number",
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        counterText: "",
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 233, 232, 238),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Send OTP"),
                    ),
                    if (otpSent) ...[
                      const SizedBox(height: 20),
                      TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Enter OTP",
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 0.9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 228, 233, 228),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Verify OTP"),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
