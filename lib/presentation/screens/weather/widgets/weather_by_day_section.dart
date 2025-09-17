import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/constants/app_image.dart';
import 'package:helios/core/constants/helpers.dart';
import 'package:helios/core/util/weather_helper.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:helios/presentation/components/app_text.dart';
import 'package:helios/presentation/screens/weather/weather_detail_controller.dart';

class WeatherByDaySection extends StatelessWidget {
  const WeatherByDaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherDetailController>(
      builder: (controller) {
        return Column(
          children: [
            Row(
              children: [
                AppText(
                  text: "Next forecast",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                const Spacer(),
                const Icon(CupertinoIcons.calendar, color: Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: () {
                if (controller
                        .completeWeather
                        .value
                        ?.forecast
                        .forecastday
                        .isNotEmpty ==
                    true) {
                  final forecastDays =
                      controller.completeWeather.value!.forecast.forecastday;
                  return SingleChildScrollView(
                    child: Column(
                      children: forecastDays.map((forecastDay) {
                        return _buildWeatherByDayItem(forecastDay: forecastDay);
                      }).toList(),
                    ),
                  );
                } else {
                  // Fallback to mock data if no forecast data
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        7,
                        (i) => _buildWeatherByDayItemFallback(
                          day: Helper.getFormattedDateWithShortMonth(
                            offsetDays: i,
                          ),
                          icon: AppImage.windy,
                          temperature: "${29 + i} °C",
                        ),
                      ),
                    ),
                  );
                }
              }(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeatherByDayItem({required ForecastDay forecastDay}) {
    // Format date to show day name (e.g., "Today", "Tomorrow", "Wednesday")
    final date = DateTime.parse(forecastDay.date);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(date.year, date.month, date.day);

    String dayText;
    if (itemDate.isAtSameMomentAs(today)) {
      dayText = "Today";
    } else if (itemDate.isAtSameMomentAs(today.add(const Duration(days: 1)))) {
      dayText = "Tomorrow";
    } else {
      dayText = Helper.getFormattedDateWithShortMonth(
        offsetDays: itemDate.difference(today).inDays,
      );
    }

    // Get appropriate weather image
    final weatherImage = WeatherHelper.getWeatherImage(
      forecastDay.day.condition.code,
      isDay: true, // Use day image for daily forecast
    );

    // Format temperature range
    final temperatureRange = WeatherHelper.formatTemperatureRange(
      forecastDay.day.mintempC,
      forecastDay.day.maxtempC,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 50),
          SizedBox(
            width: 80,
            child: AppText(
              text: dayText,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Image.asset(
            weatherImage,
            width: 30,
            height: 30,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AppImage.windy, width: 30, height: 30);
            },
          ),
          const Spacer(),
          SizedBox(
            width: 70,
            child: AppText(
              text: temperatureRange,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildWeatherByDayItemFallback({
    required String day,
    required String icon,
    required String temperature,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(width: 50),
          AppText(
            text: day,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const Spacer(),
          Image.asset(icon, scale: 5),
          const Spacer(),
          AppText(
            text: temperature,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}
