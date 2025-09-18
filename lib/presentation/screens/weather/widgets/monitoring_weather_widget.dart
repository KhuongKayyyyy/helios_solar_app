import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:helios/core/constants/app_color.dart';
import 'package:helios/core/constants/app_image.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:helios/presentation/components/app_text.dart';
import 'package:helios/presentation/screens/weather/weather_detail_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MonitoringWeatherWidget extends StatefulWidget {
  final WeatherModel? weather;
  final bool isLoading;
  final String? fieldLocation;
  final VoidCallback? onWeatherDetailTap;

  const MonitoringWeatherWidget({
    super.key,
    required this.weather,
    this.isLoading = false,
    this.fieldLocation,
    this.onWeatherDetailTap,
  });

  @override
  State<MonitoringWeatherWidget> createState() =>
      _MonitoringWeatherWidgetState();
}

class _MonitoringWeatherWidgetState extends State<MonitoringWeatherWidget> {
  Gemini gemini = Gemini.instance;
  String recommendation =
      "Water your plants in the morning or evening when the temperature is cooler to minimize evaporation.";
  StringBuffer fullRecommendation = StringBuffer();
  bool isLoading = true; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    _fetchRecommendation();
  }

  @override
  void didUpdateWidget(MonitoringWeatherWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fetch recommendation when weather data becomes available
    if (oldWidget.weather == null && widget.weather != null) {
      _fetchRecommendation();
    }
  }

  void _fetchRecommendation() {
    // Only fetch recommendation if weather data is available
    if (widget.weather == null) {
      return;
    }

    setState(() {
      isLoading = true; // Start loading
      fullRecommendation.clear(); // Clear previous recommendation
    });

    // Extract meaningful weather data for Gemini
    final weatherData = widget.weather!;
    final weatherInfo =
        """
Location: ${weatherData.location.name}
Temperature: ${weatherData.current.tempC}°C
Condition: ${weatherData.current.condition.text}
Humidity: ${weatherData.current.humidity}%
Wind: ${weatherData.current.windKph} km/h
UV Index: ${weatherData.current.uv}
""";

    gemini
        .promptStream(
          parts: [
            Part.text(
              "Based on this current weather data, predict today's solar farm energy yield in concise 25 words for farmers:\n$weatherInfo",
            ),
          ],
        )
        .listen((value) {
          setState(() {
            fullRecommendation.write(value?.output ?? "");
            recommendation = fullRecommendation.toString();
          });
        })
        .onDone(() {
          setState(() {
            isLoading = false; // Stop loading when done
          });
          if (kDebugMode) {
            print("Final Recommendation: $recommendation");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppColors.mediumWhite, Colors.white],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: "Weather", fontWeight: FontWeight.bold),
          Row(children: [_buildTemperature(), _buildFarmTip()]),
          _buildWeatherDetail(),
        ],
      ),
    );
  }

  Widget _buildTemperature() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Skeletonizer(
        enabled: widget.isLoading || widget.weather == null,
        enableSwitchAnimation: true,
        child: Column(
          children: [
            Image.asset(AppImage.hot_sun, scale: 14),
            AppText(
              text: widget.weather != null
                  ? "${widget.weather!.current.tempC.round()}°C"
                  : "25°C",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
            AppText(
              text: 'Today ',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmTip() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: "Tips", fontWeight: FontWeight.bold),
            const SizedBox(height: 10),
            Skeletonizer(
              enabled: widget.isLoading || widget.weather == null || isLoading,
              enableSwitchAnimation: true,
              child: AppText(
                text: recommendation,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail() {
    return InkWell(
      onTap: () {
        _showWeatherDetail(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AppText(
                text: "More detail",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showWeatherDetail(BuildContext context) {
    if (widget.onWeatherDetailTap != null) {
      widget.onWeatherDetailTap!();
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return WeatherDetailPage(location: widget.fieldLocation);
        },
      );
    }
  }
}
