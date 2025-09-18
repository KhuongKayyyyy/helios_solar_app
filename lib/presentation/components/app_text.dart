import 'package:flutter/material.dart';
import 'package:helios/core/constants/color_constants.dart';
import 'package:helios/core/constants/string_constants.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  TextDecoration? textDecoration;
  String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  TextAlign? textAlign;
  FontStyle? fontStyle;
  TextOverflow? overflow = TextOverflow.ellipsis;
  int? maxLine;
  int? maxLength;
  double? height;
  double? width;
  double? letterSpacing;

  AppText({
    super.key,
    required this.text,
    this.color,
    this.fontFamily,
    this.height,
    this.textAlign,
    this.overflow,
    this.maxLine,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.width,
    this.maxLength,
    this.letterSpacing,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,
      style: TextStyle(
        height: height,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: color ?? ColorConstants.appBlack,
        fontFamily: fontFamily ?? StringConstants.Pretendard,
        fontSize: fontSize ?? 14,
        letterSpacing: letterSpacing ?? 0.02,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? ColorConstants.appBlack,
      ),
    );
  }
}
