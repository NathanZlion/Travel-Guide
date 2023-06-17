import '../../destination/model/destination_model.dart';
import '../../hotel/model/hotel_model.dart';
import '../../restaurant/model/restaurant_model.dart';

class Cart {
  late List<Hotel> hotels;
  late List<Restaurant> restaurants;
  late List<Destination> destinations;

  Cart(
      {required this.hotels,
      required this.restaurants,
      required this.destinations});

  Cart.fromJson(Map<String, dynamic> json) {
    hotels = json['hotels'];
    restaurants = json['restaurants'];
    destinations = json['destinations'];
  }

  Map<String, dynamic> toJson() {
    return {
      'hotels': hotels,
      'restaurants': restaurants,
      'destinations': destinations,
    };
  }
}
