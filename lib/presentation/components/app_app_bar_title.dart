import 'package:flutter/material.dart';
import 'package:helios/presentation/components/app_text.dart';

class AppAppBarTitle extends StatelessWidget {
  final String title;
  const AppAppBarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AppText(
        text: title,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
