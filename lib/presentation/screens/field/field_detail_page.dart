import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/core/util/extensions.dart';
import 'package:helios/data/models/field/field_model.dart';
import 'package:helios/presentation/components/app_app_bar_title.dart';
import 'package:helios/presentation/components/app_back_button.dart';
import 'package:helios/presentation/screens/field/field_heading_section.dart';
import 'package:helios/presentation/screens/field/panel_group_list.dart';
import 'package:helios/presentation/screens/field/field_weather_controller.dart';
import 'package:helios/presentation/screens/weather/widgets/monitoring_weather_widget.dart';
import 'package:helios/presentation/screens/weather/weather_detail_page.dart';

class FieldDetailPage extends StatefulWidget {
  final FieldModel field;
  const FieldDetailPage({super.key, required this.field});

  @override
  State<FieldDetailPage> createState() => _FieldDetailPageState();
}

class _FieldDetailPageState extends State<FieldDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  late FieldWeatherController _weatherController;

  @override
  void initState() {
    super.initState();

    // Initialize weather controller
    _weatherController = Get.put(
      FieldWeatherController(),
      tag: widget.field.id,
    );

    // Fetch weather data for this field
    _weatherController.fetchWeatherForField(widget.field.location);

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      if (offset > 330 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      } else if (offset <= 330 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Clean up weather controller
    Get.delete<FieldWeatherController>(tag: widget.field.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 350,
            pinned: true,
            leadingWidth: 80,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SizedBox(height: 20, width: 20, child: AppBackButton()),
            ),
            title: _showTitle
                ? AppAppBarTitle(title: widget.field.name ?? '')
                : null,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "field_image_${widget.field.id ?? 'unknown'}",
                child: Image.network(
                  height: MediaQuery.of(context).size.height * 0.4,
                  widget.field.imageURL ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 60,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate([FieldHeadingSection()]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverToBoxAdapter(
              child: GetBuilder<FieldWeatherController>(
                tag: widget.field.id,
                builder: (controller) {
                  return MonitoringWeatherWidget(
                    weather: controller.currentWeather.value,
                    isLoading: controller.isLoading.value,
                    fieldLocation: widget.field.location,
                    onWeatherDetailTap: () => _showWeatherDetail(context),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // _buildPanelSectionGrid(),
                PanelGroupList(),
                200.y,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeatherDetail(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return WeatherDetailPage(location: widget.field.location);
      },
    );
  }
}
