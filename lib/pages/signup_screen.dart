import 'package:budget_tracker/pages/select_currency_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Title
                Text(
                  "Hi!\nWelcome",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Let's create an account",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 30),

                // Email / Phone
                _inputField("Email or phone number"),

                const SizedBox(height: 16),

                // Full name
                _inputField("Full Name"),

                const SizedBox(height: 16),

                // Username
                _inputField("Username"),

                const SizedBox(height: 16),

                // Password
                _inputField("Password", isPassword: true),

                const SizedBox(height: 16),

                // Confirm password
                _inputField("Confirm Password", isPassword: true),

                const SizedBox(height: 30),

                // Signup button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Select Currency screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectCurrencyScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Login link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // back to login
                    },
                    child: const Text(
                      "Already have an account? Log in",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable input field
  Widget _inputField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
