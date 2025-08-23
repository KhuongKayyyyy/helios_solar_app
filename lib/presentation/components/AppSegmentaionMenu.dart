import 'package:flutter/material.dart';
import 'package:helios/core/constants/ColorConstants.dart';
import 'package:helios/presentation/components/AppText.dart';

class AppSegmentationMenu extends StatefulWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final double? height;
  final double? borderRadius;

  const AppSegmentationMenu({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.height,
    this.borderRadius,
  });

  @override
  State<AppSegmentationMenu> createState() => _AppSegmentationMenuState();
}

class _AppSegmentationMenuState extends State<AppSegmentationMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: widget.height ?? 40,
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? ColorConstants.appBlack.withOpacity(0.2),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
        border: Border.all(color: ColorConstants.hintTextColor, width: 1),
      ),
      child: Row(
        children: widget.items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;
          bool isSelected = index == widget.selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onItemSelected(index),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (widget.selectedColor ?? ColorConstants.appBlack)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    (widget.borderRadius ?? 20) - 2,
                  ),
                ),
                child: Center(
                  child: AppText(
                    text: item,
                    color: isSelected
                        ? Colors.white
                        : (widget.unselectedColor ?? ColorConstants.appBlack),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
