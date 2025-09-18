import 'package:get/get.dart';
import 'package:helios/core/constants/nav_ids.dart';
import 'package:helios/data/app_data/app_exports.dart';
import 'package:helios/presentation/screens/usage/usage_page.dart';

class UsageRouter extends StatelessWidget {
  const UsageRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.usage),
      onGenerateRoute: (settings) {
        return GetPageRoute(settings: settings, page: () => UsagePage());
      },
    );
  }
}
