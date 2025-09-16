import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/controllers/main_wrapper_controller.dart';
import 'package:helios/core/router/home_router.dart';
import 'package:helios/core/router/profile_router.dart';
import 'package:helios/core/router/statistic_router.dart';
import 'package:helios/core/router/usage_router.dart';
import 'package:helios/presentation/components/app_bottom_navigation.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
    // Initialize the controller
    Get.put(MainWrapperController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: MainWrapperController.to.currentIndex,
          children: [
            HomeRouter(),
            UsageRouter(),
            StatisticsRouter(),
            ProfileRouter(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => AppBottomNavigation(
          currentIndex: MainWrapperController.to.currentIndex,
          onTap: (index) => MainWrapperController.to.setCurrentIndex(index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Usage',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
