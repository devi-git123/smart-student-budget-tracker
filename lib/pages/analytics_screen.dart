import 'dart:math';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9),
      appBar: AppBar(title: const Text("Analytics"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ===== SUMMARY CARDS =====
            Row(
              children: const [
                Expanded(
                  child: _SummaryCard(
                    title: "Total Spend",
                    value: "\$1,250",
                    icon: Icons.trending_down,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: "Highest",
                    value: "Education",
                    icon: Icons.school,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// ===== BAR CHART =====
            _Card(
              title: "Monthly Expenses",
              child: SizedBox(
                height: 180,
                child: CustomPaint(painter: BarChartPainter()),
              ),
            ),

            const SizedBox(height: 16),

            /// ===== PIE CHART =====
            _Card(
              title: "Category Distribution",
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CustomPaint(painter: AnalyticsPiePainter()),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(child: _Legend()),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ===== DETAILS =====
            _Card(
              title: "Detailed Analytics",
              child: Column(
                children: const [
                  _AnalyticsRow("Food", "\$300", Colors.orange),
                  _AnalyticsRow("Transport", "\$200", Colors.blue),
                  _AnalyticsRow("Education", "\$500", Colors.teal),
                  _AnalyticsRow("Utilities", "\$250", Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= SUMMARY CARD =================
class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// ================= CARD WRAPPER =================
class _Card extends StatelessWidget {
  final String title;
  final Widget child;

  const _Card({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// ================= BAR CHART =================
class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.teal;

    final values = [300.0, 450.0, 200.0, 500.0, 250.0];
    final barWidth = size.width / (values.length * 2);
    final maxValue = values.reduce(max);

    for (int i = 0; i < values.length; i++) {
      final barHeight = (values[i] / maxValue) * size.height;
      final x = i * barWidth * 2 + barWidth / 2;
      final y = size.height - barHeight;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(6),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

/// ================= PIE CHART =================
class AnalyticsPiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()..style = PaintingStyle.fill;

    final values = [300.0, 200.0, 500.0, 250.0];
    final colors = [Colors.orange, Colors.blue, Colors.teal, Colors.grey];

    double startAngle = -pi / 2;
    final total = values.reduce((a, b) => a + b);

    for (int i = 0; i < values.length; i++) {
      final sweep = (values[i] / total) * 2 * pi;
      paint.color = colors[i];
      canvas.drawArc(rect, startAngle, sweep, true, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

/// ================= LEGEND =================
class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _LegendItem("Food", Colors.orange),
        _LegendItem("Transport", Colors.blue),
        _LegendItem("Education", Colors.teal),
        _LegendItem("Utilities", Colors.grey),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final String text;
  final Color color;

  const _LegendItem(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

/// ================= ANALYTICS ROW =================
class _AnalyticsRow extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;

  const _AnalyticsRow(this.title, this.amount, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(radius: 8, backgroundColor: color),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
