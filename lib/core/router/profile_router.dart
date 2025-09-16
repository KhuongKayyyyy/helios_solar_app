import 'package:get/get.dart';
import 'package:helios/core/constants/nav_ids.dart';
import 'package:helios/data/app_data/app_exports.dart';

import 'package:helios/presentation/screens/profile/profile_page.dart';

class ProfileRouter extends StatelessWidget {
  const ProfileRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NavIds.profile),
      onGenerateRoute: (settings) {
        return GetPageRoute(settings: settings, page: () => ProfilePage());
      },
    );
  }
}
