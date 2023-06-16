
            // "_id": "63eea370a61fa4470ba8b8ef",
            // "name": "Capital Hotel and Spa ",
            // "location": "Addis Ababa",
            // "description": "\nCapital Hotel and Spa is one of the few finest Five Star Hotels in the capital city Addis Ababa-Ethiopia. Located just minutes away from Bole International Airport, Capital Hotel and Spa is a great accessible place with open main road to and from different parts of the city; thus, the hotel is an ideal location for the activities happening in Addis Ababa.",
            // "image": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/03/7e/0d/king-standard-room.jpg?w=600&h=600&s=1"


class Hotel {
  late String id;
  late String name;
  late String location;
  late String description;
  late String image;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.image,
  });


  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['location'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'location': location,
      'description': description,
      'image': image,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'image': image,
    };
  }


  @override
  String toString() {
    return 'Hotel{id: $id, name: $name, location: $location, description: $description, image: $image}';
  }
}