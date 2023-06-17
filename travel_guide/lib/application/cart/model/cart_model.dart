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

  Cart.fromJson(json) {
    hotels = [];
    restaurants = [];
    destinations = [];

    for (var hotel in json['hotels']) {
      hotels.add(Hotel.fromJson(hotel));
    }

    for (var restaurant in json['restaurants']) {
      restaurants.add(Restaurant.fromJson(restaurant));
    }

    for (var destination in json['destinations']) {
      destinations.add(Destination.fromJson(destination));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'hotels': hotels,
      'restaurants': restaurants,
      'destinations': destinations,
    };
  }
}
