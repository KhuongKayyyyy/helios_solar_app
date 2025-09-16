import 'package:flutter/material.dart';
import 'package:helios/core/constants/color_constants.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: LiquidGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: Radius.circular(100)),
        child: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorConstants.black,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
