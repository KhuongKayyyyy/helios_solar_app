class PanelGroup {
  final String? id;
  final String? name;
  final int? sectionCount;
  final String? powerRating;
  final double? efficiency;

  PanelGroup({this.id, this.name, this.sectionCount, this.powerRating, this.efficiency});

  static List<PanelGroup> getMockData() {
    return [
      PanelGroup(id: '1', name: 'Section 1', sectionCount: 1, powerRating: '1.2KW', efficiency: 75.5, ),
      PanelGroup(id: '2', name: 'Section 2', sectionCount: 2, powerRating: '2.4KW', efficiency: 82.3),
      PanelGroup(id: '3', name: 'Section 3', sectionCount: 3, powerRating: '3.6KW', efficiency: 78.9),
      PanelGroup(id: '4', name: 'Section 4', sectionCount: 4, powerRating: '6.2KW', efficiency: 89.4),
      PanelGroup(id: '5', name: 'Section 5', sectionCount: 5, powerRating: '8.1KW', efficiency: 94.7),
        PanelGroup(id: '6', name: 'Section 6', sectionCount: 6, powerRating: '10.8KW', efficiency: 97.2),
      PanelGroup(id: '7', name: 'Section 7', sectionCount: 7, powerRating: '12.6KW', efficiency: 98.5),
      PanelGroup(id: '8', name: 'Section 8', sectionCount: 8, powerRating: '14.4KW', efficiency: 99.1),
    ];
  }
}
