import 'package:flutter/material.dart';
import 'package:helios/core/constants/color_constants.dart';
import 'package:helios/core/constants/constants.dart';
import 'package:helios/core/constants/string_constants.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  TextDecoration? textDecoration;
  String text;
  Color? textColor;
  Color? disableTextColor;
  Color? color;
  Color? disableColor;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  TextAlign? textAlign;
  TextOverflow? overflow;
  Function() onTap;
  int? maxLine;
  double? borderRadius;
  double? margin;
  double? height;
  double? width;
  BoxBorder? border;
  bool? disabled;
  String? image;

  AppButton({
    super.key,
    required this.text,
    this.color,
    this.disableTextColor,
    this.disableColor,
    this.fontFamily,
    this.height,
    this.textAlign,
    this.overflow,
    this.maxLine,
    this.margin,
    this.borderRadius,
    required this.onTap,
    this.width,
    this.textColor,
    this.disabled,
    this.fontSize,
    this.border,
    this.image,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      margin: EdgeInsets.only(
        left: margin ?? sideMargin,
        right: margin ?? sideMargin,
      ),
      decoration: BoxDecoration(
        color: disabled ?? false
            ? disableColor ?? ColorConstants.appGrayBG
            : color ?? ColorConstants.btnDefaultColor,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 40)),
        child: Material(
          color: disabled ?? false
              ? disableColor ?? ColorConstants.appGrayMiddle
              : color ?? ColorConstants.btnDefaultColor,
          child: InkWell(
            onTap: disabled ?? false ? () {} : onTap,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (image != null)
                    Row(
                      children: [
                        Image.asset(image!, width: 30, height: 30),
                        const SizedBox(width: 6),
                      ],
                    ),
                  Text(
                    text,
                    textAlign: textAlign ?? TextAlign.center,
                    overflow: overflow,
                    maxLines: maxLine,
                    style: TextStyle(
                      decoration: textDecoration ?? TextDecoration.none,
                      fontFamily: StringConstants.Pretendard,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      fontSize: fontSize ?? 16,
                      letterSpacing: 0.02,
                      color: disabled ?? false
                          ? disableTextColor ?? ColorConstants.white
                          : textColor ?? ColorConstants.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
