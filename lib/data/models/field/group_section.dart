class GroupSection {
  final String? title;
  final String? description;
  final String? grid;

  GroupSection({this.title, this.description, this.grid});

  static List<GroupSection> getMockData() {
    return [
      GroupSection(
        title: 'North Wing Section A',
        description:
            'Primary solar array facing north for optimal morning sun exposure',
        grid: '3x4',
      ),
      GroupSection(
        title: 'South Wing Section B',
        description:
            'High-efficiency panels with maximum afternoon sun capture',
        grid: '4x6',
      ),
      GroupSection(
        title: 'East Rooftop Array',
        description: 'Early morning energy generation cluster',
        grid: '2x3',
      ),
      GroupSection(
        title: 'West Building Extension',
        description: 'Evening sun optimization panel group',
        grid: '5x4',
      ),
      GroupSection(
        title: 'Central Courtyard Grid',
        description: 'Main power generation hub with tracking capabilities',
        grid: '6x8',
      ),
      GroupSection(
        title: 'Storage Facility Roof',
        description: 'Compact installation for warehouse operations',
        grid: '3x3',
      ),
      GroupSection(
        title: 'Administration Block',
        description: 'Office building supplementary power system',
        grid: '4x5',
      ),
      GroupSection(
        title: 'Parking Structure Canopy',
        description: 'Dual-purpose solar canopy providing shade and energy',
        grid: '8x10',
      ),
      GroupSection(
        title: 'Manufacturing Plant Section',
        description: 'Industrial-grade panels for heavy power consumption',
        grid: '7x6',
      ),
      GroupSection(
        title: 'Research Laboratory Wing',
        description: 'Precision monitoring solar installation',
        grid: '3x5',
      ),
      GroupSection(
        title: 'Maintenance Depot Array',
        description: 'Service building renewable energy supply',
        grid: '4x4',
      ),
      GroupSection(
        title: 'Security Gate Station',
        description: 'Entrance facility backup power generation',
        grid: '2x2',
      ),
    ];
  }
}
