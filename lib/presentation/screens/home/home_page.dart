import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/constants/nav_ids.dart';
import 'package:helios/core/controllers/home_controller.dart';
import 'package:helios/core/router/route_name.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteName.weatherDetail, id: NavIds.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Go to Weather Detail',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
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
