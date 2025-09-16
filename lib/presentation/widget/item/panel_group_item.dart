import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get/get_core/src/get_main.dart";
import "package:helios/core/constants/nav_ids.dart";
import "package:helios/core/router/route_name.dart";
import "package:helios/data/models/panel_group.dart";
import "package:helios/presentation/components/app_text.dart";
import "dart:math";

import "package:helios/presentation/screens/field/panel_group_detail_page.dart";

class PanelGroupItem extends StatelessWidget {
  final PanelGroup panelGroup;
  const PanelGroupItem({super.key, required this.panelGroup});

  // Random value generator for demonstration
  String _getRandomYield() {
    final random = Random();
    final value = (random.nextDouble() * 100).toStringAsFixed(1);
    return '$value KWh';
  }

  String _getRandomEarnings() {
    final random = Random();
    final value = (random.nextInt(1000) + 50);
    return '$value BDT';
  }

  String _getRandomPowerRating() {
    final random = Random();
    final value = (random.nextDouble() * 5 + 2).toStringAsFixed(1);
    return '${value}KW';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteName.panelGroupDetail,
          arguments: panelGroup,
          id: NavIds.home,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE6F3A5),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular progress indicator with power rating
            Center(
              child: Container(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    // Outer circle (background)
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFD4E68A),
                      ),
                    ),
                    // Inner circle
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE6F3A5),
                        ),
                      ),
                    ),
                    // Progress arc
                    CustomPaint(
                      size: Size(120, 120),
                      painter: CircularProgressPainter(),
                    ),
                    // Power rating text
                    Center(
                      child: AppText(
                        text: panelGroup.powerRating ?? _getRandomPowerRating(),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Sunshine and location info
            Row(
              children: [
                Icon(Icons.wb_sunny, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                AppText(
                  text: 'Sunshine 06:15-17:49 (UTC-4:00)',
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                AppText(
                  text: 'Kaliganj,Cloudy 17/19 C',
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Divider
            Container(
              height: 1,
              color: Colors.black.withOpacity(0.2),
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),

            // Yield statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatColumn('Today Yield', _getRandomYield()),
                _buildStatColumn('Monthly Yield', _getRandomYield()),
                _buildStatColumn('Total Yield', _getRandomYield()),
              ],
            ),

            const SizedBox(height: 15),

            // Earnings statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatColumn('Today Earni...', _getRandomEarnings()),
                _buildStatColumn('Monthly Ea...', _getRandomEarnings()),
                _buildStatColumn('Total Earni...', _getRandomEarnings()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: title, fontSize: 12, color: Colors.black54),
        const SizedBox(height: 2),
        AppText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw arc (approximately 180 degrees, bottom half)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 3),
      0.5, // Start angle (in radians, roughly 90 degrees)
      3.14, // Sweep angle (in radians, roughly 180 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
