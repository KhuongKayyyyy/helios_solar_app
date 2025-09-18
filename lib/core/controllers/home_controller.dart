import 'package:get/get.dart';
import 'package:helios/data/models/field/field_model.dart';

class HomeController extends GetxController {
  final RxList<FieldModel> fields = <FieldModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fields.value = FieldMockData.mockFields;
  }
}
