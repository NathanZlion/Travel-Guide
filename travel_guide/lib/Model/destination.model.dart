
class Destination {

  late String name;
  late String description;
  late String image;

  Destination({required this.name, required this.description, required this.image});
  // add more properties here

  Destination.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

}