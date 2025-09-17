import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helios/core/constants/helpers.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:helios/presentation/components/app_text.dart';

class CurrentWeatherInformation extends StatelessWidget {
  final WeatherModel currentWeather;
  const CurrentWeatherInformation({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(
              color: Colors.white.withOpacity(0.15),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text:
                        "${currentWeather.location.name}, ${Helper.getFormattedDate()}",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 10),
                  AppText(
                    text: "${currentWeather.current.tempC.round()}°C",
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 15),
                  AppText(
                    text: currentWeather.current.condition.text,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Icon(CupertinoIcons.wind, color: Colors.white),
                      const SizedBox(width: 5),
                      AppText(
                        text: "Wind",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      const Spacer(),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 70,
                        child: AppText(
                          text:
                              "${currentWeather.current.windKph.round()} km/h",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Icon(CupertinoIcons.drop, color: Colors.white),
                      const SizedBox(width: 5),
                      AppText(
                        text: "Hum ",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      const Spacer(),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 70,
                        child: AppText(
                          text: "${currentWeather.current.humidity}%",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
