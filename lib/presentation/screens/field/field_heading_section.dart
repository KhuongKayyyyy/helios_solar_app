import 'package:flutter/material.dart';
import 'package:helios/presentation/components/app_text.dart';

class FieldHeadingSection extends StatelessWidget {
  const FieldHeadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Overview',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _FieldStatsCard(
                  title: 'Total Energy',
                  value: '1200',
                  unit: 'kWh',
                  icon: Icons.flash_on,
                  color: const Color(0xFF22C55E),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FieldStatsCard(
                  title: 'Consumed',
                  value: '810',
                  unit: 'kWh',
                  icon: Icons.pie_chart,
                  color: const Color(0xFF84CC16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FieldStatsCard(
                  title: 'Capacity',
                  value: '10.80',
                  unit: 'kWh',
                  icon: Icons.view_in_ar,
                  color: const Color(0xFF6B7280),
                  valueColor: const Color(0xFF374151),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FieldStatsCard(
                  title: 'CO2 Reduction',
                  value: '12.68',
                  unit: 'ton',
                  icon: Icons.eco,
                  color: const Color(0xFF059669),
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

  const _FieldStatsCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E8ED), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppText(
                text: title,
                fontSize: 14,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
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
              AppText(
                text: value,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: valueColor ?? color,
              ),
              const SizedBox(width: 4),
              AppText(
                text: unit,
                fontSize: 14,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
