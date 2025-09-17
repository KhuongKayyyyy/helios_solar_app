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
      name: 'Trang trại Đồng Nắng',
      location: 'Thành phố Hồ Chí Minh, Việt Nam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.excellent,
    ),
    FieldModel(
      id: '2',
      name: 'Cánh đồng Xanh',
      location: 'Hà Nội, Việt Nam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.good,
    ),
    FieldModel(
      id: '3',
      name: 'Trang trại Mùa Vàng',
      location: 'Đà Nẵng, Việt Nam',
      imageURL:
          'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=400&h=300&fit=crop',
      condition: FieldCondition.fair,
    ),
    FieldModel(
      id: '4',
      name: 'Nông trại Gió Đồng',
      location: 'Cần Thơ, Việt Nam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.excellent,
    ),
    FieldModel(
      id: '5',
      name: 'Cánh đồng Ven Sông',
      location: 'Hải Phòng, Việt Nam',
      imageURL:
          'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=400&h=300&fit=crop',
      condition: FieldCondition.good,
    ),
    FieldModel(
      id: '6',
      name: 'Trang trại Núi Cao',
      location: 'Đà Lạt, Việt Nam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.poor,
    ),
    FieldModel(
      id: '7',
      name: 'Nông nghiệp Đồng Bằng Duyên Hải',
      location: 'Nha Trang, Việt Nam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.good,
    ),
    FieldModel(
      id: '8',
      name: 'Trang trại Hoa Sa Mạc',
      location: 'Huế, Việt Nam',
      imageURL:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkuNOa0kb5OvZU_NsOQTgV3yLHBe5jivfMPg&s',
      condition: FieldCondition.fair,
    ),
  ];
}
