import 'package:flutter/material.dart';

void main() => runApp(const StudentBudgetApp());

class StudentBudgetApp extends StatelessWidget {
  const StudentBudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2D6A7B),
      ),
      home: const StudentDashboard(),
    );
  }
}

// --- SCREEN 1: DASHBOARD ---
class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey, Alex!",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const Text(
                        "Student Budgeter",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D6A7B),
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=student',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Main Balance Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D6A7B), Color(0xFF72C4D6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    // ignore: deprecated_member_use
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Monthly Allowance",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "LKR 45,000.00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _balanceInfo("Spent", "LKR 12,400"),
                        _balanceInfo("Remaining", "LKR 32,600"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Spending Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _categoryIcon(Icons.fastfood, "Food", Colors.orange),
                    _categoryIcon(Icons.library_books, "Tuition", Colors.blue),
                    _categoryIcon(Icons.directions_bus, "Travel", Colors.green),
                    _categoryIcon(Icons.movie, "Fun", Colors.purple),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              const Text(
                "Recent Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              _transactionItem(
                "Cafeteria Lunch",
                "Food",
                "- LKR 450",
                Icons.restaurant,
                Colors.orange,
              ),
              _transactionItem(
                "Monthly Bus Pass",
                "Travel",
                "- LKR 1,200",
                Icons.directions_bus,
                Colors.green,
              ),
              _transactionItem(
                "Notebooks & Pens",
                "Edu",
                "- LKR 850",
                Icons.edit,
                Colors.blue,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildModernNav(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2D6A7B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _balanceInfo(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _categoryIcon(IconData icon, String label, Color color) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15),
      // ignore: deprecated_member_use
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(
    String title,
    String cat,
    String price,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            // ignore: deprecated_member_use
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                cat,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernNav(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.dashboard_rounded,
                color: Color(0xFF2D6A7B),
              ),
              onPressed: () {},
            ),

            // NAVIGATION TRIGGER BUTTON
            IconButton(
              icon: const Icon(Icons.bar_chart_rounded, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecurringPaymentScreen(),
                  ),
                );
              },
            ),

            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// --- SCREEN 2: RECURRING PAYMENTS ---
class RecurringPaymentScreen extends StatelessWidget {
  const RecurringPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Recurring payments",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Month Highlight Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFA6D34E), // Green color from wireframe
                borderRadius: BorderRadius.circular(20),
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
            const SizedBox(height: 30),

            // Utility Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  _utilityTile(Icons.water_drop, "Water", "LKR 2850"),
                  _utilityTile(Icons.bolt, "Electricity", "LKR 3250"),
                  _utilityTile(Icons.home, "Rent", "LKR 12500"),
                  _utilityTile(Icons.wifi, "Internet", "LKR 1580"),
                ],
              ),
            ),

            // Footer Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // This would link to the Utility Tracker form
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3BA7C8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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

  Widget _utilityTile(IconData icon, String title, String amount) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green, size: 30),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            amount,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
