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

                Hour? hourData;

                final isPastHour = itemTime.isBefore(now);

                if (isPastHour) {
                  if (controller
                          .historyWeather
                          .value
                          ?.forecast
                          .forecastday
                          .isNotEmpty ==
                      true) {
                    final historyDays =
                        controller.historyWeather.value!.forecast.forecastday;

                    for (
                      int dayIndex = 0;
                      dayIndex < historyDays.length;
                      dayIndex++
                    ) {
                      final historyDay = historyDays[dayIndex];
                      final historyDate = DateTime.parse(historyDay.date);

                      if (historyDate.year == itemTime.year &&
                          historyDate.month == itemTime.month &&
                          historyDate.day == itemTime.day) {
                        for (
                          int hourIndex = 0;
                          hourIndex < historyDay.hour.length;
                          hourIndex++
                        ) {
                          final hour = historyDay.hour[hourIndex];
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
                  if (controller
                          .completeWeather
                          .value
                          ?.forecast
                          .forecastday
                          .isNotEmpty ==
                      true) {
                    final forecastDays =
                        controller.completeWeather.value!.forecast.forecastday;

                    for (final forecastDay in forecastDays) {
                      final forecastDate = DateTime.parse(forecastDay.date);
                      if (forecastDate.year == itemTime.year &&
                          forecastDate.month == itemTime.month &&
                          forecastDate.day == itemTime.day) {
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
