import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../application/hotel/hotel.dart';

class ApiDataProvider {
  final String BASE_URL = "http://localhost:5000/api";

  Future<List<Hotel>> getHotels(name, location) async {
    final response = await http
        .get(Uri.parse("$BASE_URL/hotel?name=$name&location=$location"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      // convert the json object to a list of hotels
      final List<Hotel> hotels = [];

      for (var item in json) {
        hotels.add(Hotel.fromJson(item));
      }

      return hotels;
    } else {
      throw Exception("Error getting hotels");
    }
  }

  Future<Hotel> getHotel(String id) async {
    final response = await http.get(Uri.parse("$BASE_URL/hotel/$id"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];
      print(json);
      print(Hotel.fromJson(json));

      return Hotel.fromJson(json);
    } else {
      throw Exception("Error getting destination");
    }
  }
}
