import 'package:get/get.dart';
import 'package:helios/core/constants/nav_ids.dart';
import 'package:helios/core/router/route_name.dart';
import 'package:helios/data/app_data/app_exports.dart';
import 'package:helios/data/models/field/field_model.dart';
import 'package:helios/presentation/screens/field/field_detail_page.dart';
import 'package:helios/presentation/screens/field/panel_group_detail_page.dart';
import 'package:helios/presentation/screens/home/home_page.dart';
import 'package:helios/presentation/screens/weather/weather_detail_page.dart';
import 'package:helios/presentation/screens/weather/weather_detail_controller.dart';

class HomeRouter extends StatelessWidget {
  const HomeRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.home),
      onGenerateRoute: (settings) {
        if (settings.name == RouteName.fieldDetail) {
          return GetPageRoute(
            settings: settings,
            page: () =>
                FieldDetailPage(field: settings.arguments as FieldModel),
          );
        } else if (settings.name == RouteName.panelGroupDetail) {
          return GetPageRoute(
            settings: settings,
            page: () => PanelGroupDetailPage(),
          );
        } else if (settings.name == RouteName.weatherDetail) {
          final location = settings.arguments as String?;
          return GetPageRoute(
            settings: settings,
            page: () => WeatherDetailPage(location: location),
            binding: BindingsBuilder(() {
              Get.lazyPut(
                () => WeatherDetailController()..setLocation(location),
              );
            }),
          );
        }
        return GetPageRoute(settings: settings, page: () => HomePage());
      },
    );
  }
}
