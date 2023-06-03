import 'dart:convert';

import '../model/destination_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiDataProvider { 
  final String API_URL = dotenv.env['BASE_URL']!;
  // final String API_/

  Future<List<Destination>> fetchDestinations() async {
    final response = await http
        .get(Uri.parse('https://www.mocky.io/v2/5ebd3f0f31000018005b117f'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((data) => Destination.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load destinations');
    }
  }

  Future<Destination> fetchDestination(String id) async {
    final response = await http
        .get(Uri.parse('https://www.mocky.io/v2/5ebd3f0f31000018005b117f'));
    if (response.statusCode == 200) {
      return Destination.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load destinations');
    }
  }
}
