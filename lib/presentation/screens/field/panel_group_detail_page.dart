import "package:flutter/material.dart";
import "package:helios/core/util/extensions.dart";
import "package:helios/data/models/field/group_section.dart";
import "package:helios/presentation/components/app_back_button.dart";
import "package:helios/presentation/widget/item/field_panel_section_item.dart";
import "package:fl_chart/fl_chart.dart";
import "dart:math";

class PanelGroupDetailPage extends StatefulWidget {
  const PanelGroupDetailPage({super.key});

  @override
  State<PanelGroupDetailPage> createState() => _PanelGroupDetailPageState();
}

class _PanelGroupDetailPageState extends State<PanelGroupDetailPage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;
  final List<GroupSection> _panelSections = GroupSection.getMockData();

  // Random values that change with each item
  double _powerOutput = 0;
  double _voltage = 0;
  double _current = 0;
  double _energyProduction = 0;
  double _growthPercentage = 0;
  List<FlSpot> _chartData = [];

  @override
  void initState() {
    super.initState();
    _generateRandomData();
  }

  void _generateRandomData() {
    final random = Random();
    _powerOutput = 200 + random.nextDouble() * 300; // 200-500W
    _voltage = 30 + random.nextDouble() * 15; // 30-45V
    _current = 5 + random.nextDouble() * 10; // 5-15A
    _energyProduction = 1.5 + random.nextDouble() * 3; // 1.5-4.5 kWh
    _growthPercentage = random.nextDouble() * 30; // 0-30%
    _chartData = _generateDailyChartData();
  }

  // Parse grid string (e.g., "3x4") to get rows and columns
  Map<String, int> _parseGrid(String? grid) {
    if (grid == null) return {'rows': 3, 'cols': 3};
    final parts = grid.split('x');
    if (parts.length != 2) return {'rows': 3, 'cols': 3};
    return {
      'rows': int.tryParse(parts[0]) ?? 3,
      'cols': int.tryParse(parts[1]) ?? 3,
    };
  }

  // Generate sample chart data for daily production
  List<FlSpot> _generateDailyChartData() {
    final random = Random();
    List<FlSpot> spots = [];

    // Generate hourly data from 6AM to 6PM (12 hours)
    for (int hour = 0; hour < 12; hour++) {
      double value;
      if (hour < 2 || hour > 10) {
        // Low production in early morning and late evening
        value = 0.1 + random.nextDouble() * 0.3;
      } else if (hour >= 4 && hour <= 8) {
        // Peak production around midday
        value = 0.7 + random.nextDouble() * 0.3;
      } else {
        // Moderate production
        value = 0.4 + random.nextDouble() * 0.4;
      }
      spots.add(FlSpot(hour.toDouble(), value));
    }
    return spots;
  }

  Widget _buildLiveDataSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Data',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Power Output',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_powerOutput.toInt()} W',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voltage',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_voltage.toInt()} V',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_current.toStringAsFixed(1)} A',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyProductionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Production',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Energy Production',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Text(
            '${_energyProduction.toStringAsFixed(1)} kWh',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Today ',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                '+${_growthPercentage.toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Daily production chart
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) {
                          return const Text(
                            '6AM',
                            style: TextStyle(fontSize: 10),
                          );
                        }
                        if (value == 6) {
                          return const Text(
                            '12PM',
                            style: TextStyle(fontSize: 10),
                          );
                        }
                        if (value == 11) {
                          return const Text(
                            '6PM',
                            style: TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 1,
                lineBarsData: [
                  LineChartBarData(
                    spots: _chartData,
                    isCurved: true,
                    color: Colors.blue[300],
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      // ignore: deprecated_member_use
                      color: Colors.blue[100]!.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridMap(GroupSection section) {
    final gridData = _parseGrid(section.grid);
    final rows = gridData['rows']!;
    final cols = gridData['cols']!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Panel Grid Layout (${section.grid})',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: cols / rows,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                // Random panel status for demo
                final random = Random(_currentIndex * 1000 + index);
                final isActive = random.nextBool();
                return Container(
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green[400] : Colors.red[300],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[600]!, width: 0.5),
                  ),
                  child: Center(
                    child: Icon(
                      isActive ? Icons.wb_sunny : Icons.warning,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(height: 20, width: 20, child: AppBackButton()),
        title: const Text('Panel Group Detail'),
      ),
      body: Column(
        children: [
          kToolbarHeight.y,
          // PageView to show only one item at a time (replacing ListView)
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _generateRandomData(); // Generate new random data when item changes
                });
              },
              itemCount: _panelSections.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == index
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FieldPanelSectionItem(
                    panelSection: _panelSections[index],
                  ),
                );
              },
            ),
          ),

          // Details section for the current panel
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _panelSections[_currentIndex].title ??
                              "Panel Section $_currentIndex",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _panelSections[_currentIndex].description ??
                              'No description available',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Live Data Section
                  _buildLiveDataSection(),
                  const SizedBox(height: 16),

                  // Daily Production Section
                  _buildDailyProductionSection(),
                  const SizedBox(height: 16),

                  // Grid Map
                  _buildGridMap(_panelSections[_currentIndex]),
                  const SizedBox(height: 16),

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.flash_on,
                                color: Colors.green[600],
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Active Panels',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${(_parseGrid(_panelSections[_currentIndex].grid)['rows']! * _parseGrid(_panelSections[_currentIndex].grid)['cols']! * 0.8).round()}/${_parseGrid(_panelSections[_currentIndex].grid)['rows']! * _parseGrid(_panelSections[_currentIndex].grid)['cols']!}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.power,
                                color: Colors.orange[600],
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Efficiency',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${(85 + (_currentIndex * 2) % 10)}%',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
