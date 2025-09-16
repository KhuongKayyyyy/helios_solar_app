import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/constants/nav_ids.dart';
import 'package:helios/data/models/field_model.dart';
import 'package:helios/presentation/components/app_text.dart';
import 'package:helios/presentation/screens/field/field_detail_page.dart';

class FieldItem extends StatelessWidget {
  final FieldModel field;
  const FieldItem({super.key, required this.field});

  String _getConditionText(FieldCondition? condition) {
    switch (condition) {
      case FieldCondition.excellent:
        return 'Excellent condition';
      case FieldCondition.good:
        return 'Good condition';
      case FieldCondition.fair:
        return 'Fair condition';
      case FieldCondition.poor:
        return 'Poor condition';
      default:
        return 'Unknown condition';
    }
  }

  Color _getConditionColor(FieldCondition? condition) {
    switch (condition) {
      case FieldCondition.excellent:
        return Colors.green;
      case FieldCondition.good:
        return Colors.lightGreen;
      case FieldCondition.fair:
        return Colors.orange;
      case FieldCondition.poor:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate with the field object and ensure proper Hero animation
        Get.to(
          () => FieldDetailPage(field: field),
          id: NavIds.home,
          transition: Transition.fadeIn,
        );
      },
      child: Container(
        width: 200,
        height: 240,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: Hero(
                tag: "field_image_${field.id ?? 'unknown'}",
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: field.imageURL != null
                        ? DecorationImage(
                            image: NetworkImage(field.imageURL!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: field.imageURL == null ? Colors.grey[300] : null,
                  ),
                  child: field.imageURL == null
                      ? const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 40,
                          ),
                        )
                      : null,
                ),
              ),
            ),
            // Content section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Condition text
                    AppText(
                      text: _getConditionText(field.condition),
                      color: _getConditionColor(field.condition),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: field.name ?? 'Unknown Field',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            maxLine: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4285F4),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
