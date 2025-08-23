import 'package:flutter/material.dart';
import 'package:helios/core/constants/ColorConstants.dart';
import 'package:helios/core/constants/ImageConstants.dart';
import 'package:helios/core/constants/ImageUtils.dart';
import 'package:helios/core/constants/StringConstants.dart';

import 'AppText.dart';

class AppCheckBox extends StatefulWidget {
  AppCheckBox({
    super.key,
    required this.isChecked,
    required this.name,
    this.onTapCheck,
    this.image,
    this.textStyle,
    this.onTapText,
    this.checkedBox,
    this.unCheckedBox,
  });
  String name;
  bool isChecked;
  Function(bool)? onTapCheck;
  TextStyle? textStyle;
  Function()? onTapText;
  String? checkedBox;
  String? image;
  String? unCheckedBox;

  @override
  State<AppCheckBox> createState() => _AppCheckBox();
}

class _AppCheckBox extends State<AppCheckBox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant AppCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          if (widget.onTapCheck != null) {
            widget.onTapCheck!(isChecked);
          }
        });
      },
      child: Container(
        height: widget.image != null ? 40 : 30,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Image.asset(
              isChecked
                  ? widget.checkedBox ?? "${iconPath}ic_checked.png"
                  : widget.unCheckedBox ?? "${iconPath}ic_unchecked.png",
              width: 24,
            ),
            const SizedBox(width: 10),
            if (widget.image != null)
              Row(
                children: [
                  ImageUtils.ProfileImage(widget.image!, 40, 40),
                  const SizedBox(width: 8),
                ],
              ),
            GestureDetector(
              onTap: () {
                if (widget.onTapText != null) {
                  widget.onTapText!();
                } else {
                  setState(() {
                    isChecked = !isChecked;
                    if (widget.onTapCheck != null) {
                      widget.onTapCheck!(isChecked);
                    }
                  });
                }
              },
              child: AppText(
                text: widget.name,
                fontSize: widget.textStyle?.fontSize ?? 16,
                fontFamily:
                    widget.textStyle?.fontFamily ?? StringConstants.Pretendard,
                fontWeight: widget.textStyle?.fontWeight ?? FontWeight.w400,
                color: widget.textStyle?.color ?? ColorConstants.appBlack,
                textDecoration: widget.onTapText != null
                    ? TextDecoration.underline
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
