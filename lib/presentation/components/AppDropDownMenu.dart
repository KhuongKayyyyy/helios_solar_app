import 'package:flutter/material.dart';
import 'package:helios/core/constants/ColorConstants.dart';
import 'package:helios/presentation/components/AppText.dart';

class AppDropDownMenu<T> extends StatelessWidget {
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Widget? icon;
  final bool enabled;
  final String? Function(T?)? validator;

  const AppDropDownMenu({
    super.key,
    this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.icon,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          hint: hint != null
              ? AppText(
                  text: hint!,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.hintTextColor,
                )
              : null,
          icon:
              icon ??
              Icon(
                Icons.keyboard_arrow_down,
                color: ColorConstants.hintTextColor,
              ),
          isExpanded: true,
          style: TextStyle(
            color: ColorConstants.appBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          dropdownColor: ColorConstants.white,
        ),
      ),
    );
  }
}
