import 'package:get/get.dart';
import 'package:helios/core/constants/nav_ids.dart';
import 'package:helios/data/app_data/app_exports.dart';
import 'package:helios/presentation/screens/statistics/statistics_page.dart';

class StatisticsRouter extends StatelessWidget {
  const StatisticsRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.statistic),
      onGenerateRoute: (settings) {
        return GetPageRoute(settings: settings, page: () => StatisticsPage());
      },
    );
  }
}
