import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../application/restaurant/restaurant.dart';

class ApiDataProvider {
  final String BASE_URL = "http://localhost:5000/api";

  Future<List<Restaurant>> getRestaurants(name, location) async {
    final response = await http
        .get(Uri.parse("$BASE_URL/restaurant?name=$name&location=$location"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      // convert the json object to a list of restaurants
      final List<Restaurant> restaurants = [];

      for (var item in json) {
        restaurants.add(Restaurant.fromJson(item));
      }
      print(json);

      return restaurants;
    } else {
      throw Exception("Error getting restaurants");
    }
  }

  Future<Restaurant> getRestaurant(String id) async {
    final response = await http.get(Uri.parse("$BASE_URL/restaurant/$id"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      return Restaurant.fromJson(json);
    } else {
      throw Exception("Error getting restaurant");
    }
  }
}
