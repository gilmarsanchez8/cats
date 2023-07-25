class Cat {
  late String id;
  late String name;
  late String origin;
  late String description;
  late int adaptability;
  late int intelligence;
  late String lifeSpan;
  String? referenceImageId;
  String? urlImage;

  Cat({
    required this.id,
    required this.name,
    required this.origin,
    required this.description,
    required this.adaptability,
    required this.intelligence,
    required this.lifeSpan,
    this.referenceImageId,
    this.urlImage,
  });

  Cat.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    origin = json["origin"];
    description = json["description"];
    adaptability = json["adaptability"];
    intelligence = json["intelligence"];
    lifeSpan = json["life_span"];
    referenceImageId = json["reference_image_id"] ?? "";
  }
}

class Cats {
  List<Cat> items = [];

  Cats();

  Cats.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final cat = Cat.fromJsonMap(item);
      items.add(cat);
    }
  }
}