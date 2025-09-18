import 'package:flutter/material.dart';
import 'package:helios/presentation/components/app_text.dart';

class FieldHeadingSection extends StatelessWidget {
  const FieldHeadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 150;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Solar Field Overview',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _FieldStatsCard(
                  title: 'Today\'s Generation',
                  value: '320',
                  unit: 'kWh',
                  icon: Icons.wb_sunny,
                  color: const Color(0xFF22C55E),
                  height: cardHeight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FieldStatsCard(
                  title: 'Current Power',
                  value: '85',
                  unit: 'kW',
                  icon: Icons.bolt,
                  color: const Color(0xFF84CC16),
                  height: cardHeight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FieldStatsCard(
                  title: 'Installed Capacity',
                  value: '150',
                  unit: 'kWp',
                  icon: Icons.solar_power,
                  color: const Color(0xFF6B7280),
                  valueColor: const Color(0xFF374151),
                  height: cardHeight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FieldStatsCard(
                  title: 'CO₂ Saved',
                  value: '210',
                  unit: 'kg',
                  icon: Icons.eco,
                  color: const Color(0xFF059669),
                  height: cardHeight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FieldStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final Color? valueColor;
  final double? height;

  const _FieldStatsCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    this.valueColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Ensure even spacing
        children: [
          Row(
            children: [
              Flexible(
                child: AppText(
                  text: title,
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.visible,
                ),
              ),
              const Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: AppText(
                  text: value,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? color,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: AppText(
                  text: unit,
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
