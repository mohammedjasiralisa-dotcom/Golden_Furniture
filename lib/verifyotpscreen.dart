import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String phoneNumber;
  final String name;
  final TextEditingController otpController = TextEditingController();

  VerifyOtpScreen({
    super.key,
    required this.phoneNumber,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "OTP sent to $phoneNumber",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otpController.text == "1234") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Welcome $name! OTP Verified Successfully 🎉"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid OTP ❌")),
                        );
                      }
                    },
                    child: const Text("Verify"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
