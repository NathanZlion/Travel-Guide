class Restaurant {
  late String name;
  late String address;
  late String phone;
  late String image;

  Restaurant(
      {required this.name,
      required this.address,
      required this.phone,
      required this.image});

  Restaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
  }
}
