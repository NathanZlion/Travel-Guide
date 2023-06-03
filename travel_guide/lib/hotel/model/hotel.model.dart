class Hotel {
  late String name;
  late String address;
  late String phone;
  late String email;
  late String website;
  late String description;
  late String image;

  Hotel(
      {required this.name,
      required this.address,
      required this.phone,
      required this.email,
      required this.website,
      required this.description,
      required this.image});

  Hotel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
    description = json['description'];
    image = json['image'];
  }
}
