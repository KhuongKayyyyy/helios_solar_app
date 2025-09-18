import 'dart:ui';

import 'package:flutter/foundation.dart';
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
    DateTime currentTime = DateTime.now();
    bool isCurrentTime =
        currentTime.hour == time.hour && currentTime.day == time.day;

    // Show skeleton if no data available
    if (hourData == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: kIsWeb
            ? Container(
                decoration: BoxDecoration(
                  color: isCurrentTime
                      // ignore: deprecated_member_use
                      ? Colors.white.withOpacity(0.3)
                      : Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
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
                      baseColor: Colors.white.withOpacity(0.3),
                    ),
                  ],
                ),
              )
            : BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: BoxDecoration(
                    color: isCurrentTime
                        // ignore: deprecated_member_use
                        ? Colors.white.withOpacity(0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
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
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        baseColor: Colors.white.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ),
      );
    }

    // Format the temperature and get weather image
    String temperature = WeatherHelper.formatTemperature(hourData!.tempC);
    String weatherImage = WeatherHelper.getWeatherImage(
      hourData!.condition.code,
      isDay: hourData!.isDay == 1,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: kIsWeb
          ? Container(
              decoration: BoxDecoration(
                color: isCurrentTime
                    // ignore: deprecated_member_use
                    ? Colors.white.withOpacity(0.3)
                    : Colors.white.withOpacity(0.15),
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
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(AppImage.windy, width: 24, height: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${time.hour.toString().padLeft(2, '0')}:00",
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            )
          : BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: BoxDecoration(
                  color: isCurrentTime
                      // ignore: deprecated_member_use
                      ? Colors.white.withOpacity(0.3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
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
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(AppImage.windy, width: 24, height: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${time.hour.toString().padLeft(2, '0')}:00",
                      style: TextStyle(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
