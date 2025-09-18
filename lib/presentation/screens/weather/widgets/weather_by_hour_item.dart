import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helios/core/constants/app_image.dart';
import 'package:helios/core/util/weather_helper.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:helios/presentation/widgets/skeleton_loading.dart';

class WeatherByHourItem extends StatelessWidget {
  final DateTime time;
  final Hour? hourData;
  const WeatherByHourItem({super.key, required this.time, this.hourData});

  @override
  Widget build(BuildContext context) {
    // Get the current time without minutes and seconds for comparison
    DateTime currentTime = DateTime.now();
    bool isCurrentTime =
        currentTime.hour == time.hour && currentTime.day == time.day;

    // Show skeleton if no data available
    if (hourData == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: BoxDecoration(
              color: isCurrentTime
                  // ignore: deprecated_member_use
                  ? Colors.white.withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SkeletonLoading(
                  width: 40,
                  height: 12,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                const SizedBox(height: 10),
                const SkeletonLoading(
                  width: 24,
                  height: 24,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                const SizedBox(height: 10),
                SkeletonLoading(
                  width: 35,
                  height: 12,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  // ignore: deprecated_member_use
                  baseColor: Colors.white.withOpacity(0.1),
                  // ignore: deprecated_member_use
                  highlightColor: Colors.white.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Use real data
    final temperature = WeatherHelper.formatTemperature(hourData!.tempC);
    final weatherImage = WeatherHelper.getWeatherImage(
      hourData!.condition.code,
      isDay: hourData!.isDay == 1,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentTime
                // ignore: deprecated_member_use
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                temperature,
                style: const TextStyle(
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                weatherImage,
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(AppImage.windy, width: 24, height: 24);
                },
              ),
              const SizedBox(height: 10),
              Text(
                "${time.hour.toString().padLeft(2, '0')}:00",
                style: const TextStyle(
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
