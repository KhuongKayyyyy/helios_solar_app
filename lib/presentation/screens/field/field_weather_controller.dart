import 'package:get/get.dart';
import 'package:helios/data/services/weather/weather_service.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FieldWeatherController extends GetxController {
  final WeatherService _weatherService = Get.find<WeatherService>();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final currentWeather = Rx<WeatherModel?>(null);

  /// Fetch weather data for a specific field location
  Future<void> fetchWeatherForField(String? fieldLocation) async {
    if (fieldLocation == null || fieldLocation.isEmpty) {
      errorMessage.value = 'Field location not available';
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Check API key
      final apiKey = dotenv.env['WEATHER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('WEATHER_API_KEY not found in .env file');
      }

      final weather = await _weatherService
          .getCurrentWeather(fieldLocation)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Request timeout: Please check your internet connection',
              );
            },
          );

      currentWeather.value = weather;

      // Trigger UI updates
      update();
    } catch (e) {
      errorMessage.value =
          'Failed to fetch weather data. Please check your internet connection and try again.';

      // Reset data on error
      currentWeather.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear weather data
  void clearWeatherData() {
    currentWeather.value = null;
    errorMessage.value = '';
    isLoading.value = false;
  }

  @override
  void onClose() {
    clearWeatherData();
    super.onClose();
  }
}
