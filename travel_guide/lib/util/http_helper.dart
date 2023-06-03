import 'package:http/http.dart' show get, post, put, delete;
import 'dart:convert';
import 'package:travel_guide/destination/model/destination_model.dart';
import 'package:travel_guide/hotel/model/hotel.model.dart';
import 'package:travel_guide/restaurant/model/restaurant.model.dart';

class HttpHelper {
  // free api from https://rapidapi.com/apidojo/api/travel-advisor
  final String urlBase = 'https://travel-advisor.p.rapidapi.com';
  // ethiopia geoid
  String geoId = '293791';
  final String API_KEY = "c3ac8e5784msh45fc0af7386f089p102dc2jsn1b5647ad4e3c";
  final String API_HOST = "travel-advisor.p.rapidapi.com";

  final String hotel = "https://hotels4.p.rapidapi.com/locations/v3/";
  final String search = "/search";

/*
https://hotels4.p.rapidapi.com/locations/v3/search?q=Ethiopia

*/

  Future<List<Hotel>> getHotels() async {
    var response = await get(Uri.parse('$urlBase/hotels'));
    var data = json.decode(response.body);
    List<Hotel> hotels = [];
    for (var jsonData in data) {
      Hotel hotel = Hotel.fromJson(jsonData);
      hotels.add(hotel);
    }
    return hotels;
  }

  Future<List<Restaurant>> getRestaurants() async {
    var response = await get(Uri.parse('$urlBase/restaurants'));
    var data = json.decode(response.body);
    List<Restaurant> restaurants = [];
    for (var r in data) {
      Restaurant restaurant = Restaurant.fromJson(r);
      restaurants.add(restaurant);
    }
    return restaurants;
  }

  // search for a hotel
  Future<List<Hotel>> searchHotels(String query) async {
    var response = await get(Uri.parse('$urlBase/hotels/search?query=$query'));
    var data = json.decode(response.body);
    List<Hotel> hotels = [];
    for (var h in data) {
      Hotel hotel = Hotel.fromJson(h);
      hotels.add(hotel);
    }
    return hotels;
  }

  // search for a restaurant
  Future<List<Restaurant>> searchRestaurants(String query) async {
    var response =
        await get(Uri.parse('$urlBase/restaurants/search?query=$query'));
    var data = json.decode(response.body);
    List<Restaurant> restaurants = [];
    for (var r in data) {
      Restaurant restaurant = Restaurant.fromJson(r);
      restaurants.add(restaurant);
    }
    return restaurants;
  }

  // search for a destination
  Future<List<Destination>> searchDestinations(String query) async {
    var response =
        await get(Uri.parse('$urlBase/destinations/search?query=$query'));
    var data = json.decode(response.body);
    List<Destination> destinations = [];
    for (var d in data) {
      Destination destination = Destination.fromJson(d);
      destinations.add(destination);
    }
    return destinations;
  }

  Future<List<Destination>> getDestinations() async {
    var response = await get(Uri.parse('$urlBase/destinations'));
    var data = json.decode(response.body);
    List<Destination> destinations = [];
    for (var d in data) {
      Destination destination = Destination.fromJson(d);
      destinations.add(destination);
    }
    return destinations;
  }
}
