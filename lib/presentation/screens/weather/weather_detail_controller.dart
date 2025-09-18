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

  /// Set location and load weather data
  void setLocation(String? newLocation) {
    if (newLocation != null && newLocation.isNotEmpty) {
      location.value = newLocation;
      loadAllWeatherData();
    }
  }

  Future<void> getCompleteWeather() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final apiKey = dotenv.env['WEATHER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('WEATHER_API_KEY not found in .env file');
      }

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

      completeWeather.value = weather;

      currentWeather.value = WeatherModel(
        location: weather.location,
        current: weather.current,
      );

      update();
    } catch (e) {
      errorMessage.value =
          'Failed to fetch weather data. Please check your internet connection and try again.';

      completeWeather.value = null;
      currentWeather.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadAllWeatherData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final apiKey = dotenv.env['WEATHER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('WEATHER_API_KEY not found in .env file');
      }

      final forecastFuture = _weatherService
          .getCompleteWeather(location.value, days: 7)
          .timeout(const Duration(seconds: 30));

      final now = DateTime.now();

      final List<Future<ForecastWeatherModel>> historyFutures = [];

      for (int i = 1; i <= 2; i++) {
        final pastDateTime = now.subtract(Duration(hours: i));
        final pastDateString = pastDateTime.toIso8601String().split('T')[0];

        historyFutures.add(
          _weatherService
              .getHistoryWeather(
                location.value,
                pastDateString,
                pastDateTime.hour,
              )
              .timeout(const Duration(seconds: 30))
              .catchError((error) {
                return ForecastWeatherModel(
                  location: Location(
                    name: location.value,
                    region: '',
                    country: '',
                    lat: 0.0,
                    lon: 0.0,
                    tzId: '',
                    localtimeEpoch: 0,
                    localtime: '',
                  ),
                  forecast: Forecast(forecastday: []),
                );
              }),
        );
      }

      final forecastResult = await forecastFuture;
      final historyResults = await Future.wait(historyFutures);

      final completeWeatherData = forecastResult;

      final Map<String, ForecastDay> historyDaysByDate = {};

      for (int i = 0; i < historyResults.length; i++) {
        final historyData = historyResults[i];

        for (final day in historyData.forecast.forecastday) {
          if (historyDaysByDate.containsKey(day.date)) {
            final existingDay = historyDaysByDate[day.date]!;
            final mergedHours = List<Hour>.from(existingDay.hour);

            for (final newHour in day.hour) {
              final newHourTime = DateTime.parse(
                newHour.time.replaceFirst(' ', 'T'),
              );
              bool hourExists = mergedHours.any((existingHour) {
                final existingHourTime = DateTime.parse(
                  existingHour.time.replaceFirst(' ', 'T'),
                );
                return existingHourTime.hour == newHourTime.hour;
              });

              if (!hourExists) {
                mergedHours.add(newHour);
              }
            }

            mergedHours.sort((a, b) {
              final timeA = DateTime.parse(a.time.replaceFirst(' ', 'T'));
              final timeB = DateTime.parse(b.time.replaceFirst(' ', 'T'));
              return timeA.compareTo(timeB);
            });

            historyDaysByDate[day.date] = ForecastDay(
              date: day.date,
              dateEpoch: day.dateEpoch,
              day: day.day,
              astro: day.astro,
              hour: mergedHours,
            );
          } else {
            historyDaysByDate[day.date] = day;
          }
        }
      }

      final List<ForecastDay> allHistoryDays = historyDaysByDate.values
          .toList();

      final combinedHistoryWeather = ForecastWeatherModel(
        location: completeWeatherData.location,
        forecast: Forecast(forecastday: allHistoryDays),
      );

      completeWeather.value = completeWeatherData;
      historyWeather.value = combinedHistoryWeather;

      currentWeather.value = WeatherModel(
        location: completeWeatherData.location,
        current: completeWeatherData.current,
      );

      update();
    } catch (e) {
      errorMessage.value =
          'Failed to fetch weather data. Please check your internet connection and try again.';

      completeWeather.value = null;
      currentWeather.value = null;
      historyWeather.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshWeather() async {
    await loadAllWeatherData();
  }
}
