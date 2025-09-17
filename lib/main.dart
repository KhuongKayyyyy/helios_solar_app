import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/binding/app_binding.dart';
import 'package:helios/core/constants/app_theme.dart';
import 'package:helios/core/controllers/home_controller.dart';
import 'package:helios/core/controllers/main_wrapper_controller.dart';
import 'package:helios/data/dio/dio_service.dart';
import 'package:helios/presentation/screens/main_wrapper/main_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DioService with environment configuration
  await DioService.initialize();

  // Initialize app bindings
  AppBinding().dependencies();

  runApp(const MyApp());

  Get.put(MainWrapperController());
  Get.put(HomeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Helios',
      theme: AppTheme.theme,
      home: const MainWrapper(),
    );
  }
}
