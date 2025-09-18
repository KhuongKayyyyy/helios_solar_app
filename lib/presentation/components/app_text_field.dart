import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helios/core/constants/color_constants.dart';
import 'package:helios/core/constants/string_constants.dart';
import 'package:helios/presentation/components/app_text.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  final TextEditingController? textController;
  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final AutovalidateMode? autoValidateMode;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Color? textColor;
  final bool? obscureText;
  final bool? isCursorEnable;
  final VoidCallback? callbackSuffix;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextDecoration? textDecoration;
  final TextDecorationStyle? textDecorationStyle;
  final Color? textDecorationColor;
  String? font;
  bool? readOnly;
  int? maxLength;
  int? minLines;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmmited;
  final String? errorText;
  final Color? textBorderColor;
  final Color? textFieldLight;
  final Color? textFieldDark;
  final Color? textColorHint;
  final Color? fillColor;
  final Color? enableBorderColor;
  final double? radius;
  final List<TextInputFormatter>? inputFormatters;
  final double? radiousFouse;
  final double? height;
  final EdgeInsets? contentPadding;
  OutlineInputBorder? border;
  final FocusNode? focusNode;
  final String? labelText;
  final Widget? counter;

  AppTextField({
    super.key,
    this.keyBoardType,
    this.autoValidateMode,
    this.focusNode,
    this.textInputAction,
    this.textController,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onSubmmited,
    this.errorText,
    this.textColor,
    this.obscureText,
    this.callbackSuffix,
    this.suffix,
    this.textDecoration,
    this.textDecorationStyle,
    this.textDecorationColor,
    this.font,
    this.textAlign,
    this.height,
    this.validator,
    this.readOnly,
    this.isCursorEnable,
    this.maxLength,
    this.onChanged,
    this.textBorderColor,
    this.textFieldLight,
    this.textFieldDark,
    this.contentPadding,
    this.textColorHint,
    this.fillColor,
    this.enableBorderColor,
    this.minLines,
    this.fontSize,
    this.maxLines,
    this.border,
    this.labelText,
    this.counter,
    this.inputFormatters,
    this.radius,
    this.radiousFouse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Column(
            children: [
              AppText(
                text: labelText!,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorConstants.color9d,
              ),
              const SizedBox(height: 10),
            ],
          ),
        TextFormField(
          focusNode: focusNode,
          keyboardType: keyBoardType,
          readOnly: readOnly ?? false,
          textAlign: textAlign ?? TextAlign.start,
          enabled: isCursorEnable ?? true,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          autovalidateMode: autoValidateMode,
          validator: validator,
          textInputAction: textInputAction,
          onTap: onTap,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          controller: textController,
          onFieldSubmitted: onSubmmited,
          inputFormatters: inputFormatters ?? [],
          style: TextStyle(
            color: readOnly ?? false
                ? ColorConstants.appGrayBtn
                : textColor ?? Colors.black,
            fontFamily: font ?? StringConstants.Pretendard,
            fontSize: fontSize ?? 16,
            letterSpacing: 0.02,
            height: height ?? 1.5,
            fontWeight: FontWeight.w400,
            decoration: textDecoration ?? TextDecoration.none,
            decorationStyle: textDecorationStyle ?? TextDecorationStyle.solid,
            decorationColor: textDecorationColor ?? Colors.transparent,
          ),
          decoration: InputDecoration(
            counterText: '',
            enabledBorder:
                border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.appGrayMiddle),
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
            focusedErrorBorder:
                border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.appGrayMiddle),
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
            focusedBorder: readOnly ?? false
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.appGrayMiddle),
                    borderRadius: BorderRadius.circular(radius ?? 8),
                  )
                : border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.appColor),
                        borderRadius: BorderRadius.circular(radius ?? 8),
                      ),
            border:
                border ??
                OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.appGrayMiddle),
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
            fillColor:
                fillColor ??
                (readOnly ?? false ? ColorConstants.appGrayBG : Colors.white),
            filled: true,
            hintText: hintText,
            suffix: suffix,
            errorText: errorText,
            hintStyle: TextStyle(
              fontFamily: font ?? StringConstants.Pretendard,
              color: textColorHint ?? ColorConstants.color9d,
              fontSize: fontSize ?? 16,
              letterSpacing: 0.02,
              height: height ?? 1.5,
              decoration: textDecoration ?? TextDecoration.none,
              decorationStyle: textDecorationStyle ?? TextDecorationStyle.solid,
              decorationColor: textDecorationColor ?? Colors.transparent,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            counter: counter,
            suffixIconConstraints: const BoxConstraints(
              maxHeight: double.maxFinite,
            ),
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
