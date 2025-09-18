import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/constants/app_color.dart';
import 'package:helios/core/constants/app_image.dart';
import 'package:helios/presentation/screens/weather/weather_detail_controller.dart';
import 'package:helios/presentation/screens/weather/widgets/current_weather_information.dart';
import 'package:helios/presentation/screens/weather/widgets/weather_by_day_section.dart';
import 'package:helios/presentation/screens/weather/widgets/weather_by_hour_section.dart';
import 'package:helios/presentation/widgets/skeleton_loading.dart';

class WeatherDetailPage extends GetView<WeatherDetailController> {
  const WeatherDetailPage({super.key});

  bool _isDayTime(DateTime now) {
    return now.hour >= 6 && now.hour < 18;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      DateTime now = DateTime.now();
      if (controller.currentWeather.value != null) {
        try {
          final localtimeStr =
              controller.currentWeather.value!.location.localtime;
          final localtime = DateTime.parse(localtimeStr.replaceFirst(' ', 'T'));
          now = localtime;
        } catch (_) {
          // fallback to device time if parsing fails
        }
      }
      bool isDayTime = _isDayTime(now);

      return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: controller.refreshWeather,
            ),
            if (controller.isLoading.value)
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDayTime
                    ? [
                        AppColors.white,
                        AppColors.primaryColor,
                      ] // Day gradient (white and primary)
                    : [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ], // Night gradient (primary and secondary)
              ),
            ),
            child: Stack(
              children: [
                isDayTime
                    ? Positioned(
                        top: 50,
                        right: -100,
                        child: Image.asset(AppImage.sun_back, width: 200),
                      )
                    : Positioned(
                        top: 50,
                        right: -50,
                        child: Image.asset(AppImage.moon_back, width: 200),
                      ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: RefreshIndicator(
                    onRefresh: controller.refreshWeather,
                    color: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Container(
                              width: 100,
                              height: 5,
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Image.asset(
                              AppImage.windy,
                              width: 100,
                              height: 100,
                            ),

                            const SizedBox(height: 20),
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const SkeletonCurrentWeather();
                              } else if (controller
                                  .errorMessage
                                  .value
                                  .isNotEmpty) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    controller.errorMessage.value,
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              } else if (controller.currentWeather.value !=
                                  null) {
                                return CurrentWeatherInformation(
                                  currentWeather:
                                      controller.currentWeather.value!,
                                );
                              } else {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    'No weather data available',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                            }),
                            const SizedBox(height: 20),
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const SkeletonHourlyWeather();
                              } else {
                                return const WeatherByHourSection();
                              }
                            }),
                            const SizedBox(height: 20),
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const SkeletonDailyWeather();
                              } else {
                                return const WeatherByDaySection();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                isDayTime
                    ? Positioned(
                        top: 320,
                        left: -50,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Image.asset(AppImage.cloud, width: 200),
                        ),
                      )
                    : Positioned(
                        top: 320,
                        left: -50,
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Image.asset(AppImage.star_back, width: 200),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
