import 'package:flutter/material.dart';

// This functions are responsible to make UI responsive across all the mobile devices.

MediaQueryData mediaQueryData = MediaQueryManager._instance.mediaQueryData;

// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 390;
const num FIGMA_DESIGN_HEIGHT = 844;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ResponsiveExtension on num {
  ///This method is used to get device viewport width.
  get _width {
    return MediaQueryManager().mediaQueryData.size.width;
  }

  ///This method is used to get device viewport height.
  get _height {
    num statusBar = MediaQueryManager().mediaQueryData.viewPadding.top;
    num bottomBar = MediaQueryManager().mediaQueryData.padding.bottom;
    num screenHeight =
        MediaQueryManager().mediaQueryData.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  ///statusBar
  get stB => MediaQueryManager().mediaQueryData.viewPadding.top;

  ///bottom bar
  get btB => MediaQueryManager().mediaQueryData.viewPadding.bottom;
  get sh => this * _height;
  get sw => this * _width;

  ///symmetric  horizontal
  ///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
  double get w => ((this * _width) / FIGMA_DESIGN_WIDTH);

  ///symmetric vertical
  ///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
  double get h =>
      (this * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR);
  double get scaleFactor {
    double baseScale = ((h + w) / 2).toDouble();
    // Adjust the multiplier to increase text size
    return baseScale +
        0.05; // You can adjust the 0.05 value to get the desired size
  }

  ///This method is used to set smallest px in image height and width [[rsa]] responsive size  adjust
  double get rSA {
    var height = h;
    var width = w;
    return height < width ? height.toDoubleValue() : width.toDoubleValue();
  }

  ///This method is used to set text font size according to Viewport
  double get fS {
    // print(scaleFactor);
    // print(h.toDoubleValue());
    // print(w.toDoubleValue());

    return scaleFactor;
  }

  double get r {
    return rSA / 2;
  }
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}

class MediaQueryManager {
  static final MediaQueryManager _instance = MediaQueryManager._internal();

  MediaQueryData? _mediaQueryData;

  factory MediaQueryManager() {
    return _instance;
  }

  MediaQueryManager._internal();

  void initialize(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  MediaQueryData setMediaQueryData(MediaQueryData mediaQueryData) {
    _mediaQueryData = mediaQueryData;
    return _mediaQueryData!;
  }

  MediaQueryData get mediaQueryData {
    if (_mediaQueryData == null) {
      throw Exception('MediaQueryManager not initialized');
    }
    return _mediaQueryData!;
  }
}
