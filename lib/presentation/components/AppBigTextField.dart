import 'package:flutter/material.dart';

class AppBigTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;

  const AppBigTextField({super.key, required this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: hintText ?? '텍스트를 입력해주세요...',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}
