import 'package:helios/data/dio/dio_service.dart';
import 'package:helios/data/models/weather/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  late final DioService _dioService;

  WeatherService() {
    _dioService = DioService(baseUrl: BaseURL.weather);
  }

  Future<WeatherModel> getCurrentWeather(String city) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('WEATHER_API_KEY is not set in .env');
    }
    final response = await _dioService.get(
      path: 'current.json',
      parameters: {'q': city, 'key': apiKey},
    );
    return WeatherModel.fromJson(response);
  }

  Future<ForecastWeatherModel> getForecastWeather(
    String city, {
    int days = 1,
    int? hour,
  }) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('WEATHER_API_KEY is not set in .env');
    }
    final parameters = {'q': city, 'key': apiKey, 'days': days.toString()};
    if (hour != null) {
      parameters['hour'] = hour.toString();
    }
    final response = await _dioService.get(
      path: 'forecast.json',
      parameters: parameters,
    );
    return ForecastWeatherModel.fromJson(response);
  }

  Future<ForecastWeatherModel> getHistoryWeather(
    String city,
    String date,
    int hour,
  ) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('WEATHER_API_KEY is not set in .env');
    }
    final response = await _dioService.get(
      path: 'history.json',
      parameters: {
        'q': city,
        'dt': date,
        'hour': hour.toString(),
        'key': apiKey,
      },
    );
    return ForecastWeatherModel.fromJson(response);
  }

  Future<CompleteWeatherModel> getCompleteWeather(
    String city, {
    int days = 7,
  }) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('WEATHER_API_KEY is not set in .env');
    }
    final response = await _dioService.get(
      path: 'forecast.json',
      parameters: {'q': city, 'key': apiKey, 'days': days.toString()},
    );
    return CompleteWeatherModel.fromJson(response);
  }
}
