import 'package:budget_tracker/pages/dashboad_screen.dart';
import 'package:flutter/material.dart';
// Import your dashboard file here if it's in another file
// import 'dashboard_screen.dart';

class SelectCurrencyScreen extends StatefulWidget {
  const SelectCurrencyScreen({super.key});

  @override
  State<SelectCurrencyScreen> createState() => _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends State<SelectCurrencyScreen> {
  String selectedCurrency = "LKR - Sri Lankan Rupee";

  final List<String> currencies = [
    "LKR - Sri Lankan Rupee",
    "USD - US Dollar",
    "EUR - Euro",
    "GBP - British Pound",
    "INR - Indian Rupee",
    "JPY - Japanese Yen",
    "AUD - Australian Dollar",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),

              // Icon Section
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // ignore: deprecated_member_use
                    color: Colors.teal.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 70,
                    color: Color(0xFF2D6A7B),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Text Content
              const Text(
                "Select base currency",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D6A7B),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Choose the currency you use most often.\nYou can change this later in settings.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 40),

              // Dropdown Styling
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCurrency,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF2D6A7B),
                    ),
                    items: currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Confirm Button with Navigation
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // 1. Navigation Logic
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentDashboard(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A7B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Confirm & Get Started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
