import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../application/restaurant/restaurant.dart';

class ApiDataProvider {
final String baseUrl = "http://10.0.2.2:5000/api";

  Future<List<Restaurant>> getRestaurants(name, location) async {
    final response = await http
        .get(Uri.parse("$baseUrl/restaurant?name=$name&location=$location"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      final List<Restaurant> restaurants = [];

      for (var item in json) {
        restaurants.add(Restaurant.fromJson(item));
      }

      return restaurants;
    } else {
      throw Exception("Error getting restaurants");
    }
  }

  Future<Restaurant> getRestaurant(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/restaurant/$id"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      return Restaurant.fromJson(json);
    } else {
      throw Exception("Error getting restaurant");
    }
  }
}
