class Restaurant {
  late String id;
  late String name;
  late String location;
  late String description;
  late List<String> images;
  late double rating;
  late String map;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.rating,
    required this.map,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['location'];
    description = json['description'];
    images = List<String>.from(json['image'] ?? []);
    rating = json['rating'];
    map = json['map'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'location': location,
      'description': description,
      'images': images,
      'rating': rating,
      'map': map,
    };
  }
}
