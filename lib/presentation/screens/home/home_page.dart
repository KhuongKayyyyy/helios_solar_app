import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:helios/core/controllers/home_controller.dart';

import 'package:helios/presentation/screens/home/home_heading.dart';
import 'package:helios/presentation/widget/item/field_item.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.pexels.com/photos/6729421/pexels-photo-6729421.jpeg?cs=srgb&dl=pexels-magic-k-24827758-6729421.jpg&fm=jpg',
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: 16,
              ),
              child: const HomeHeading(),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  return ListView.builder(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 100),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.fields.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: FieldItem(field: controller.fields[index]),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
