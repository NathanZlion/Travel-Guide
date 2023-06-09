import 'dart:convert';

import '../../application/destination/model/destination_model.dart';
import 'package:http/http.dart' as http;

class ApiDataProvider {
  final String BASE_URL = "http://localhost:5000/api";

  Future<List<Destination>> getDestinations(name, location) async {
    final response = await http
        .get(Uri.parse("$BASE_URL/destination?name=$name&location=$location"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      // convert the json object to a list of destinations
      final List<Destination> destinations = [];

      for (var item in json) {
        destinations.add(Destination.fromJson(item));
      }

      return destinations;
    } else {
      throw Exception("Error getting destinations");
    }
  }

  Future<Destination> getDestination(String id) async {
    final response = await http.get(Uri.parse("$BASE_URL/destination/$id"));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body)["data"];

      return Destination.fromJson(json);
    } else {
      throw Exception("Error getting destination");
    }
  }
}
