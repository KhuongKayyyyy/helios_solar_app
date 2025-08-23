import "package:flutter/material.dart";
import "package:helios/core/constants/ColorConstants.dart";
import "package:helios/presentation/components/AppText.dart";

class AppPlaceHolder extends StatelessWidget {
  final double width;
  final double height;
  final String? title;
  const AppPlaceHolder({
    super.key,
    required this.width,
    required this.height,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorConstants.color08d2d2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: title != null ? Center(child: AppText(text: title!)) : null,
    );
  }
}
