


/*

// sample destination data from backend

    "_id": "646de4c16d3d5b2fcdaf6dc5",
    "name": "Addis Ababa",
    "location": "Addis Ababa, Ethiopia",
    "description": "The capital city of Ethiopia, known for its rich history, diverse culture, arada people and vibrant markets.",
    "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/AddisView.jpg/1280px-AddisView.jpg",
    "rating": 4.5,
    "things_to_do": [
        "Visit the National Museum",
        "Explore the Mercato market",
        "Visit Holy Trinity Cathedral"
    ],
    "map": "https://goo.gl/maps/P1f9o4AEzKH4vWdY7",
    "createdAt": "2023-05-24T10:19:45.363Z",
    "updatedAt": "2023-05-24T10:19:45.363Z",
    "__v": 0
*/

class Destination {

  late String id;
  late String name;
  late String location;
  late String description;
  late String image;
  late double rating;
  late List<String> thingsToDo;
  late String map;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.image,
    required this.rating,
    required this.thingsToDo,
    required this.map,
  });

  Destination.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['location'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    thingsToDo = json['things_to_do'].cast<String>();
    map = json['map'];
  }

  Map<dynamic, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'location': location,
      'description': description,
      'image': image,
      'rating': rating,
      'things_to_do': thingsToDo,
      'map': map,
    };
  }

  // printing it
  @override
  String toString() {
    return 'Destination{id: $id, name: $name, location: $location, description: $description, image: $image, rating: $rating, thingsToDo: $thingsToDo, map: $map}';
  }
}
