import 'package:flutter/material.dart';

class AppBubbleChat extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final bool isReversed;

  const AppBubbleChat({
    super.key,
    required this.child,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.isReversed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isReversed)
            CustomPaint(
              size: const Size(24, 12),
              painter: BubbleTrianglePainter(
                color: backgroundColor ?? Colors.white,
                isReversed: isReversed,
              ),
            ),
          // Bubble body
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: child,
          ),
          if (!isReversed)
            CustomPaint(
              size: const Size(24, 12),
              painter: BubbleTrianglePainter(
                color: backgroundColor ?? Colors.white,
                isReversed: isReversed,
              ),
            ),
        ],
      ),
    );
  }
}

class BubbleTrianglePainter extends CustomPainter {
  final Color color;
  final bool isReversed;

  BubbleTrianglePainter({required this.color, this.isReversed = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isReversed) {
      path.moveTo(size.width / 2, 0); // top center
      path.lineTo(0, size.height); // bottom left
      path.lineTo(size.width, size.height); // bottom right
    } else {
      path.moveTo(0, 0); // left
      path.lineTo(size.width, 0); // right
      path.lineTo(size.width / 2, size.height); // bottom center
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
