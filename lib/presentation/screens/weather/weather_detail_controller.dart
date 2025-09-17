import 'package:get/get.dart';
import 'package:helios/data/services/weather/weather_service.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherDetailController extends GetxController {
  final WeatherService _weatherService = Get.find<WeatherService>();

  final location = 'Ho Chi Minh'.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final currentWeather = Rx<WeatherModel?>(null);
  final completeWeather = Rx<CompleteWeatherModel?>(null);
  final historyWeather = Rx<ForecastWeatherModel?>(null);
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      location.value = Get.arguments;
    }

    loadAllWeatherData();
  }

  Future<void> getCompleteWeather() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('🌤️ Fetching complete weather for: ${location.value}');

      // Check API key
      final apiKey = dotenv.env['WEATHER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('WEATHER_API_KEY not found in .env file');
      }
      print('🔑 API key found (length: ${apiKey.length})');

      final weather = await _weatherService
          .getCompleteWeather(location.value, days: 7)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Request timeout: Please check your internet connection',
              );
            },
          );

      print('✅ Complete weather data received successfully');
      print('📍 Location: ${weather.location.name}');
      print('🌡️ Current temp: ${weather.current.tempC}°C');
      print('📅 Forecast days: ${weather.forecast.forecastday.length}');

      completeWeather.value = weather;

      // Also populate currentWeather for backward compatibility
      currentWeather.value = WeatherModel(
        location: weather.location,
        current: weather.current,
      );

      // Trigger UI updates for GetBuilder widgets
      update();
    } catch (e) {
      print('❌ Error fetching complete weather: $e');
      errorMessage.value =
          'Failed to fetch weather data. Please check your internet connection and try again.';

      // Reset data on error
      completeWeather.value = null;
      currentWeather.value = null;
    } finally {
      isLoading.value = false;
      print('🔄 Loading state set to false');
    }
  }

  Future<void> loadAllWeatherData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('🌤️ Loading all weather data for: ${location.value}');

      // Check API key
      final apiKey = dotenv.env['WEATHER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('WEATHER_API_KEY not found in .env file');
      }
      print('🔑 API key found (length: ${apiKey.length})');

      // Load forecast data (for current and future hours/days)
      final forecastFuture = _weatherService
          .getCompleteWeather(location.value, days: 7)
          .timeout(const Duration(seconds: 30));

      // Load history data for past hours
      final now = DateTime.now();

      print(
        '🕐 Current time: ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
      );

      // We need to fetch multiple history calls for different dates if needed
      // Get the range of hours we need: -2, -1 relative to current hour
      final List<Future<ForecastWeatherModel>> historyFutures = [];

      for (int i = 1; i <= 2; i++) {
        final pastDateTime = now.subtract(Duration(hours: i));
        final pastDateString = pastDateTime.toIso8601String().split('T')[0];

        print(
          '🕐 Need history for: ${pastDateTime.day}/${pastDateTime.month} ${pastDateTime.hour}:00',
        );

        historyFutures.add(
          _weatherService
              .getHistoryWeather(
                location.value,
                pastDateString,
                pastDateTime.hour,
              )
              .timeout(const Duration(seconds: 30)),
        );
      }

      // Wait for all API calls to complete
      final forecastResult = await forecastFuture;
      final historyResults = await Future.wait(historyFutures);

      final completeWeatherData = forecastResult;

      // Combine all history data into a single structure
      final List<ForecastDay> allHistoryDays = [];
      for (final historyData in historyResults) {
        allHistoryDays.addAll(historyData.forecast.forecastday);
      }

      // Create combined history weather model
      final combinedHistoryWeather = ForecastWeatherModel(
        location: completeWeatherData.location,
        forecast: Forecast(forecastday: allHistoryDays),
      );

      print('✅ All weather data received successfully');
      print('📍 Location: ${completeWeatherData.location.name}');
      print('🌡️ Current temp: ${completeWeatherData.current.tempC}°C');
      print(
        '📅 Forecast days: ${completeWeatherData.forecast.forecastday.length}',
      );
      print('📊 History days collected: ${allHistoryDays.length}');

      completeWeather.value = completeWeatherData;
      historyWeather.value = combinedHistoryWeather;

      // Also populate currentWeather for backward compatibility
      currentWeather.value = WeatherModel(
        location: completeWeatherData.location,
        current: completeWeatherData.current,
      );

      // Trigger UI updates for GetBuilder widgets
      update();
    } catch (e) {
      print('❌ Error loading weather data: $e');
      errorMessage.value =
          'Failed to fetch weather data. Please check your internet connection and try again.';

      // Reset data on error
      completeWeather.value = null;
      currentWeather.value = null;
      historyWeather.value = null;
    } finally {
      isLoading.value = false;
      print('🔄 Loading state set to false');
    }
  }

  /// Refresh weather data
  Future<void> refreshWeather() async {
    await loadAllWeatherData();
  }
}
