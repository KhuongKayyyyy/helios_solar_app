import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:helios/presentation/screens/weather/weather_detail_controller.dart';
import 'package:helios/presentation/screens/weather/widgets/weather_by_hour_item.dart';

class WeatherByHourSection extends StatelessWidget {
  const WeatherByHourSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherDetailController>(
      builder: (controller) {
        final DateTime now = DateTime.now();
        final int itemCount = 5;
        final int centerIndex = itemCount ~/ 2;

        const double itemWidth = 70;
        const double horizontalPadding = 10;
        final double totalItemWidth = itemWidth + horizontalPadding;
        final double listWidth = totalItemWidth * itemCount;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: listWidth,
          child: Center(
            child: ListView.builder(
              itemCount: itemCount,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int hourOffset = index - centerIndex;
                DateTime itemTime = now.add(Duration(hours: hourOffset));

                // Find matching hour data from forecast or history
                Hour? hourData;

                // Check if this is a past hour (need history data) or future hour (need forecast data)
                final isPastHour = itemTime.isBefore(now);

                // Debug: Uncomment to see which data source is used
                // print('🕐 Hour ${itemTime.hour}: ${isPastHour ? "HISTORY" : "FORECAST"} data needed');

                if (isPastHour) {
                  // Use history data for past hours
                  if (controller
                          .historyWeather
                          .value
                          ?.forecast
                          .forecastday
                          .isNotEmpty ==
                      true) {
                    final historyDays =
                        controller.historyWeather.value!.forecast.forecastday;

                    // Find the history day that matches the item time
                    for (final historyDay in historyDays) {
                      final historyDate = DateTime.parse(historyDay.date);
                      if (historyDate.year == itemTime.year &&
                          historyDate.month == itemTime.month &&
                          historyDate.day == itemTime.day) {
                        // Find the hour that matches
                        for (final hour in historyDay.hour) {
                          final hourTime = DateTime.parse(
                            hour.time.replaceFirst(' ', 'T'),
                          );
                          if (hourTime.hour == itemTime.hour) {
                            hourData = hour;
                            break;
                          }
                        }
                        break;
                      }
                    }
                  }
                } else {
                  // Use forecast data for current and future hours
                  if (controller
                          .completeWeather
                          .value
                          ?.forecast
                          .forecastday
                          .isNotEmpty ==
                      true) {
                    final forecastDays =
                        controller.completeWeather.value!.forecast.forecastday;

                    // Find the forecast day that matches the item time
                    for (final forecastDay in forecastDays) {
                      final forecastDate = DateTime.parse(forecastDay.date);
                      if (forecastDate.year == itemTime.year &&
                          forecastDate.month == itemTime.month &&
                          forecastDate.day == itemTime.day) {
                        // Find the hour that matches
                        for (final hour in forecastDay.hour) {
                          final hourTime = DateTime.parse(
                            hour.time.replaceFirst(' ', 'T'),
                          );
                          if (hourTime.hour == itemTime.hour) {
                            hourData = hour;
                            break;
                          }
                        }
                        break;
                      }
                    }
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: itemWidth,
                    child: WeatherByHourItem(
                      time: itemTime,
                      hourData: hourData,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
