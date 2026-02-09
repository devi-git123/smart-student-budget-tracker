import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

import 'analytics_screen.dart';
import 'financial_goals_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'smart_insights_screen.dart';

/// ================= TRANSACTION MODEL =================
class TransactionItem {
  final String name;
  final double amount;
  final String type; // Income | Expense
  final File? image;

  TransactionItem({
    required this.name,
    required this.amount,
    required this.type,
    this.image,
  });
}

/// ================= DASHBOARD =================
class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic>? recentPayment;

  const DashboardScreen({
    super.key,
    this.recentPayment,
    required Map<dynamic, dynamic> payment,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String userName = "Navodya Devindi";

  final List<TransactionItem> transactions = [];

  @override
  void initState() {
    super.initState();

    if (widget.recentPayment != null) {
      final p = widget.recentPayment!;
      transactions.insert(
        0,
        TransactionItem(
          name: p['name'],
          amount: p['amount'],
          type: p['type'] == 'income' ? 'Income' : 'Expense',
        ),
      );
    }
  }

  double get totalExpense => transactions
      .where((t) => t.type == 'Expense')
      .fold(0, (s, t) => s + t.amount);

  double get totalIncome => transactions
      .where((t) => t.type == 'Income')
      .fold(0, (s, t) => s + t.amount);

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9),
      drawer: _buildSidebar(),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 16),
            _buildCategoryPie(),
            const SizedBox(height: 16),
            _buildRecentTransactions(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  /// ================= APP BAR =================
  PreferredSizeWidget _buildAppBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
      "Hi, $userName 👋",
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          );
        },
      ),
    ],
  );

  /// ================= QUICK ACTIONS =================
  Widget _buildQuickActions() => Row(
    children: [
      _actionCard(
        icon: Icons.smart_toy,
        color: Colors.purple,
        title: "Smart Insights",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SmartInsightsScreen()),
          );
        },
      ),
      const SizedBox(width: 12),
      _actionCard(
        icon: Icons.flag,
        color: Colors.green,
        title: "Financial Goals",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FinancialGoalsScreen()),
          );
        },
      ),
    ],
  );

  Widget _actionCard({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    ),
  );

  /// ================= CARDS =================
  Widget _buildBalanceCard() => _card(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Total Balance", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          "LKR ${(totalIncome - totalExpense).toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  Widget _buildCategoryPie() => _card(
    Row(
      children: [
        const Expanded(
          child: Text(
            "Income vs Expense",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 90,
          height: 90,
          child: CustomPaint(
            painter: CategoryPiePainter(
              expense: totalExpense,
              income: totalIncome,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildRecentTransactions() => _card(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Transactions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (transactions.isEmpty)
          const Text(
            "No transactions yet",
            style: TextStyle(color: Colors.grey),
          ),
        ...transactions.map(_transactionItem),
      ],
    ),
  );

  Widget _transactionItem(TransactionItem tx) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: Icon(
            tx.type == 'Expense' ? Icons.arrow_upward : Icons.arrow_downward,
            color: tx.type == 'Expense' ? Colors.red : Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(tx.name)),
        Text(
          "${tx.type == 'Expense' ? '-' : '+'} LKR ${tx.amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: tx.type == 'Expense' ? Colors.red : Colors.green,
          ),
        ),
      ],
    ),
  );

  Widget _card(Widget child) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
      ],
    ),
    child: child,
  );

  /// ================= BOTTOM NAV =================
  Widget _buildBottomNav() => BottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() => _currentIndex = index);
      if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
        );
      }
      if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
      }
    },
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.teal,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.repeat), label: ''),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle, size: 36),
        label: '',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
    ],
  );

  /// ================= SIDEBAR =================
  Widget _buildSidebar() => Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.teal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 36, color: Colors.teal),
              ),
              const SizedBox(height: 10),
              Text(
                userName,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        _drawerItem(
          icon: Icons.person,
          title: "Profile",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          ),
        ),
        _drawerItem(
          icon: Icons.notifications,
          title: "Notifications",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          ),
        ),
        _drawerItem(
          icon: Icons.smart_toy,
          title: "Smart Insights",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SmartInsightsScreen()),
          ),
        ),
        _drawerItem(
          icon: Icons.flag,
          title: "Financial Goals",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FinancialGoalsScreen()),
          ),
        ),
        const Divider(),
        _drawerItem(
          icon: Icons.settings,
          title: "Settings",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
        const Spacer(),
        _drawerItem(
          icon: Icons.logout,
          title: "Logout",
          color: Colors.red,
          onTap: () => Navigator.pop(context),
        ),
        const SizedBox(height: 12),
      ],
    ),
  );

  /// ================= DRAWER ITEM =================
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) => ListTile(
    leading: Icon(icon, color: color),
    title: Text(title, style: TextStyle(color: color)),
    onTap: onTap,
  );
}

/// ================= PIE PAINTER =================
class CategoryPiePainter extends CustomPainter {
  final double expense;
  final double income;

  CategoryPiePainter({required this.expense, required this.income});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    double total = expense + income;
    double start = -pi / 2;

    if (total == 0) {
      paint.color = Colors.grey.shade300;
      canvas.drawArc(rect, 0, 2 * pi, true, paint);
      return;
    }

    paint.color = Colors.redAccent;
    canvas.drawArc(rect, start, (expense / total) * 2 * pi, true, paint);

    paint.color = Colors.green;
    canvas.drawArc(
      rect,
      start + (expense / total) * 2 * pi,
      (income / total) * 2 * pi,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
