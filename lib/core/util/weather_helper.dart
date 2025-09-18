import 'package:helios/core/constants/app_image.dart';

class WeatherHelper {
  /// Maps weather condition codes to appropriate images
  /// Based on Weather API condition codes: https://www.weatherapi.com/docs/weather_conditions.json
  static String getWeatherImage(int conditionCode, {bool isDay = true}) {
    switch (conditionCode) {
      // Clear/Sunny
      case 1000:
        return isDay ? AppImage.sun : AppImage.moon_back;

      // Partly cloudy
      case 1003:
        return isDay ? AppImage.cloudy : AppImage.many_cloud;

      // Cloudy/Overcast
      case 1006:
      case 1009:
        return AppImage.cloud;

      // Mist/Fog
      case 1030:
      case 1135:
      case 1147:
        return AppImage.cloudy;

      // Light rain/drizzle
      case 1063:
      case 1150:
      case 1153:
      case 1168:
      case 1171:
      case 1180:
      case 1183:
        return isDay ? AppImage.rain : AppImage.little_rain_at_night;

      // Moderate rain
      case 1186:
      case 1189:
      case 1192:
      case 1195:
        return isDay ? AppImage.rain : AppImage.rain_at_night;

      // Heavy rain
      case 1198:
      case 1201:
      case 1240:
      case 1243:
      case 1246:
        return isDay ? AppImage.rain : AppImage.dangerous_rain_at_night;

      // Thunderstorm
      case 1087:
      case 1273:
      case 1276:
      case 1279:
      case 1282:
        return isDay
            ? AppImage.rain_with_thunder
            : AppImage.rain_with_thunder_at_night;

      // Snow
      case 1066:
      case 1069:
      case 1072:
      case 1114:
      case 1117:
      case 1204:
      case 1207:
      case 1210:
      case 1213:
      case 1216:
      case 1219:
      case 1222:
      case 1225:
      case 1237:
      case 1249:
      case 1252:
      case 1255:
      case 1258:
      case 1261:
      case 1264:
        return AppImage
            .cloud; // Use cloud for snow as we don't have snow images

      // Ice pellets/Sleet (removed duplicate cases 1261, 1264)

      // Windy
      default:
        return AppImage.windy;
    }
  }

  /// Gets a simplified weather description for UI display
  static String getSimplifiedCondition(String condition) {
    final lower = condition.toLowerCase();

    if (lower.contains('sunny') || lower.contains('clear')) {
      return 'Sunny';
    } else if (lower.contains('partly cloudy') || lower.contains('partly')) {
      return 'Partly Cloudy';
    } else if (lower.contains('cloudy') || lower.contains('overcast')) {
      return 'Cloudy';
    } else if (lower.contains('rain') || lower.contains('drizzle')) {
      if (lower.contains('heavy')) {
        return 'Heavy Rain';
      } else if (lower.contains('light')) {
        return 'Light Rain';
      } else {
        return 'Rain';
      }
    } else if (lower.contains('thunder') || lower.contains('storm')) {
      return 'Thunderstorm';
    } else if (lower.contains('snow')) {
      return 'Snow';
    } else if (lower.contains('mist') || lower.contains('fog')) {
      return 'Foggy';
    } else if (lower.contains('wind')) {
      return 'Windy';
    } else {
      return condition; // Return original if no match
    }
  }

  /// Format temperature with proper rounding
  static String formatTemperature(double temperature) {
    return '${temperature.round()}°C';
  }

  /// Format temperature range for daily forecasts
  static String formatTemperatureRange(double min, double max) {
    return '${max.round()}° / ${min.round()}°';
  }
}
