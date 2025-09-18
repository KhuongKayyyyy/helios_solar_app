import 'package:get/get.dart';
import 'package:helios/data/dio/dio_service.dart';
import 'package:helios/data/services/weather/weather_service.dart';
import 'package:helios/presentation/screens/weather/weather_detail_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // services
    Get.lazyPut(() => DioService.instance, fenix: true);
    Get.lazyPut(() => WeatherService(), fenix: true);

    // controllers
    Get.lazyPut(() => WeatherDetailController(), fenix: true);
  }
}
