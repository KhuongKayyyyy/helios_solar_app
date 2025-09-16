enum FieldCondition { excellent, good, fair, poor }

class FieldModel {
  final String? id;
  final String? name;
  final String? location;
  final String? imageURL;
  final FieldCondition? condition;

  FieldModel({
    this.id,
    this.name,
    this.location,
    this.imageURL,
    this.condition,
  });
}

// Mock data for testing and development
class FieldMockData {
  static List<FieldModel> mockFields = [
    FieldModel(
      id: '1',
      name: 'Sunny Meadow Farm',
      location: 'Ho Chi Minh City, Vietnam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.excellent,
    ),
    FieldModel(
      id: '2',
      name: 'Green Valley Fields',
      location: 'Hanoi, Vietnam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.good,
    ),
    FieldModel(
      id: '3',
      name: 'Golden Harvest Farm',
      location: 'Da Nang, Vietnam',
      imageURL:
          'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=400&h=300&fit=crop',
      condition: FieldCondition.fair,
    ),
    FieldModel(
      id: '4',
      name: 'Prairie Wind Ranch',
      location: 'Can Tho, Vietnam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.excellent,
    ),
    FieldModel(
      id: '5',
      name: 'Riverside Cropland',
      location: 'Hai Phong, Vietnam',
      imageURL:
          'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=400&h=300&fit=crop',
      condition: FieldCondition.good,
    ),
    FieldModel(
      id: '6',
      name: 'Mountain View Farm',
      location: 'Da Lat, Vietnam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.poor,
    ),
    FieldModel(
      id: '7',
      name: 'Coastal Plains Agriculture',
      location: 'Nha Trang, Vietnam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.good,
    ),
    FieldModel(
      id: '8',
      name: 'Desert Bloom Farm',
      location: 'Hue, Vietnam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.fair,
    ),
  ];
}
