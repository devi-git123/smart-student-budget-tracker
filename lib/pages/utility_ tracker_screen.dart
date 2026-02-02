import 'package:flutter/material.dart';

void main() => runApp(const StudentFinanceApp());

class StudentFinanceApp extends StatelessWidget {
  const StudentFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const RecurringPaymentsScreen(),
    );
  }
}

// --- SCREEN 1: RECURRING PAYMENTS SUMMARY ---
class RecurringPaymentsScreen extends StatelessWidget {
  const RecurringPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Recurring p...',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Month/Due Highlight Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFA6D34E), // Light lime green from image
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "December",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        "Due in 3 days",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "LKR 1500",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Utility Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  _gridTile(Icons.water_drop, "Water", "LKR 2850"),
                  _gridTile(Icons.bolt, "Electricity", "LKR 3250"),
                  _gridTile(Icons.home, "Rent", "LKR 12500"),
                  _gridTile(Icons.wifi, "Internet", "LKR 1580"),
                ],
              ),
            ),

            // BUTTON: GO TO UTILITY TRACKER
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Navigation link to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UtilityTrackerScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF3BA7C8,
                  ), // Teal color from image
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "View utility tracker",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridTile(IconData icon, String title, String amount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green, size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// --- SCREEN 2: UTILITY TRACKER FORM ---
class UtilityTrackerScreen extends StatefulWidget {
  const UtilityTrackerScreen({super.key});

  @override
  State<UtilityTrackerScreen> createState() => _UtilityTrackerScreenState();
}

class _UtilityTrackerScreenState extends State<UtilityTrackerScreen> {
  String selectedPeriod = "Monthly";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Icon(Icons.person_search, size: 80, color: Color(0xFF2D6A7B)),
            const SizedBox(height: 10),
            const Text(
              "Utility Tracker",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D6A7B),
              ),
            ),
            const Text(
              "Add your utilities here",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Utility Type Dropdown
            _fieldLabel("Utility type"),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: const [
                DropdownMenuItem(value: "Water", child: Text("Water")),
                DropdownMenuItem(
                  value: "Electricity",
                  child: Text("Electricity"),
                ),
              ],
              onChanged: (val) {},
              hint: const Text("Select type"),
            ),

            const SizedBox(height: 20),

            // Payment Period Selector
            _fieldLabel("Payment Periodically"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _periodChip("Weekly"),
                _periodChip("Monthly"),
                _periodChip("Annual"),
              ],
            ),

            const SizedBox(height: 20),

            // Amount Field
            _fieldLabel("Amount to pay"),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Add Utility Button (Links back to summary)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Simply pop back to the previous screen
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3BA7C8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add utility",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D6A7B),
          ),
        ),
      ),
    );
  }

  Widget _periodChip(String label) {
    bool isSelected = selectedPeriod == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => setState(() => selectedPeriod = label),
      selectedColor: const Color(0xFF3BA7C8),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }
}
