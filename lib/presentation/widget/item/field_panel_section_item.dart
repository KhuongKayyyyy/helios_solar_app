import 'package:flutter/material.dart';
import 'package:helios/data/models/field/group_section.dart';
import 'package:helios/presentation/components/app_text.dart';

class FieldPanelSectionItem extends StatelessWidget {
  final GroupSection panelSection;
  const FieldPanelSectionItem({super.key, required this.panelSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.solar_power,
                    color: Color(0xFF22C55E),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: panelSection.title ?? 'Unnamed Section',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B7280).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: AppText(
                          text: 'Grid: ${panelSection.grid ?? 'N/A'}',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF9CA3AF),
                  size: 16,
                ),
              ],
            ),
            if (panelSection.description != null) ...[
              const SizedBox(height: 12),
              AppText(
                text: panelSection.description!,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
