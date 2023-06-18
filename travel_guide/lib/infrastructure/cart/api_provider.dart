import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_guide/application/cart/cart.dart';
import 'package:travel_guide/application/hotel/model/hotel_model.dart';
import 'package:travel_guide/application/restaurant/model/restaurant_model.dart';

class CartCache {
  final String baseUrl = dotenv.env['BASE_URL']!;

  // addHotel
  Future<Cart> addHotel(hotelId) async {
    // send the hotelId to the backend through the body
    final response = await http.post(
      Uri.parse("$baseUrl/cart/addHotel"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"hotelId": hotelId}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      return Cart.fromJson(json);
    } else {
      throw Exception("Error adding hotel to cart");
    }
  }

  // removeHotel
  Future<Cart> removeHotel(hotelId) async {
    // send the hotelId to the backend through the body
    final response = await http.post(
      Uri.parse("$baseUrl/cart/removeHotel"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"hotelId": hotelId}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      return Cart.fromJson(json);
    } else {
      throw Exception("Error removing hotel from cart");
    }
  }

  // addRestaurant
  Future<Cart> addRestaurant(restaurantId) async {
    // send the restaurantId to the backend through the body
    final response = await http.post(
      Uri.parse("$baseUrl/cart/addRestaurant"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"restaurantId": restaurantId}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      return Cart.fromJson(json);
    } else {
      throw Exception("Error adding restaurant to cart");
    }
  }

  // removeRestaurant
  Future<Cart> removeRestaurant(restaurantId) async {
    // send the restaurantId to the backend through the body
    final response = await http.post(
      Uri.parse("$baseUrl/cart/removeRestaurant"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"restaurantId": restaurantId}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      return Cart.fromJson(json);
    } else {
      throw Exception("Error removing restaurant from cart");
    }
  }

  // addDestination
  Future<Cart> addDestination(destinationId) async {
    // send the destinationId to the backend through the body
    final response = await http.post(
      Uri.parse("$baseUrl/cart/addDestination"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"destinationId": destinationId}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      return Cart.fromJson(json);
    } else {
      throw Exception("Error adding destination to cart");
    }
  }

  // removeDestination
  Future<Cart> removeDestination(destinationId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/cart/removeDestination"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"destinationId": destinationId}),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      return Cart.fromJson(json);
    } else {
      throw Exception("Error removing destination from cart");
    }
  }

  // getCart
  Future<Cart> getCart() async {
    final response = await http.get(Uri.parse("$baseUrl/cart"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      return Cart.fromJson(json);
    } else {
      throw Exception("Error getting cart");
    }
  }


  // clearCart
  Future<Cart> clearCart() async {
    final response = await http.delete(Uri.parse("$baseUrl/cart"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      return Cart.fromJson(json);
    } else {
      throw Exception("Error clearing cart");
    }
  }

  static Future<bool> checkItemInCart(item) async {
    Cart cart = await CartCache().getCart();

    if (item is Hotel) {
      return cart.hotels.any((hotel) => hotel.id == item.id);
    } else if (item is Restaurant) {
      return cart.restaurants.any((restaurant) => restaurant.id == item.id);
    } else {
      return cart.destinations.any((destination) => destination.id == item.id);
    }
  }
}
