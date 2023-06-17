import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import 'application/destination/model/destination_model.dart';
import 'application/hotel/model/hotel_model.dart';
import 'application/restaurant/model/restaurant_model.dart';

class SQLHelper {
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();

    return await sql.openDatabase(
      path.join(dbPath, 'localCart.db'),
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    // creating destination table
    await database.execute('''
    CREATE TABLE destinationCart (
      id TEXT PRIMARY KEY NOT NULL, name TEXT, location TEXT, description TEXT,
      image TEXT, rating REAL, thingsToDo TEXT, map TEXT
    )
    ''');

    // creating hotels cart table
    await database.execute('''
    CREATE TABLE hotelCart (
      id TEXT PRIMARY KEY NOT NULL, name TEXT, location TEXT,
      description TEXT, image TEXT
    )
    ''');

    // the restaurant cart table
    await database.execute('''
    CREATE TABLE restaurantCart (
      id TEXT PRIMARY KEY NOT NULL, name TEXT, location TEXT,
      description TEXT, image TEXT, rating REAL
    )
    ''');
  }

  static Future<List<Hotel>> getHotels(sql.Database database) async {
    final List<Map<String, dynamic>> hotels =
        await _getAllData(database, 'hotelCart');
    return hotels.map((hotel) => Hotel.fromJson(hotel)).toList();
  }

  static Future<List<Restaurant>> getRestaurants(sql.Database database) async {
    final List<Map<String, dynamic>> restaurants =
        await _getAllData(database, 'restaurantCart');
    return restaurants
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
  }

  static Future<List<Destination>> getDestinations(
      sql.Database database) async {
    final List<Map<String, dynamic>> destinations =
        await _getAllData(database, 'destinationCart');
    return destinations
        .map((destination) => Destination.fromJson(destination))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> _getAllData(
      sql.Database database, String table) async {
    return await database.query(table);
  }

  static Future<void> addItem (sql.Database database, Object item) async {
    // check the type of the item
    if (item is Hotel) {
      await _insertData(database, 'hotelCart', item.toMap());
    } else if (item is Restaurant) {
      await _insertData(database, 'restaurantCart', item.toMap());
    } else if (item is Destination) {
      await _insertData(database, 'destinationCart', item.toMap());
    }
  }

  static Future<int> _insertData(
      sql.Database database, String table, Map<String, dynamic> data) async {
    return await database.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }
  static Future<void> removeItem (sql.Database database, Object item) async {
    // check the type of the item
    if (item is Hotel) {
      await _deleteData(database, 'hotelCart', item.id);
    } else if (item is Restaurant) {
      await _deleteData(database, 'restaurantCart', item.id);
    } else if (item is Destination) {
      await _deleteData(database, 'destinationCart', item.id);
    }
  }

  static Future<int> _deleteData(
      sql.Database database, String table, String id) async {
    return await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  /// check if the item is in the cart.
  static Future<bool> isInCart(sql.Database database, Object item) {
    if (item is Hotel) {
      return _isInCart(database, 'hotelCart', item.id);
    } else if (item is Restaurant) {
      return _isInCart(database, 'restaurantCart', item.id);
    } else if (item is Destination) {
      return _isInCart(database, 'destinationCart', item.id);
    } else {
      return Future.value(false);
    }
  }

  static Future<bool> _isInCart(
      sql.Database database, String table, String id) async {
    final List<Map<String, dynamic>> data =
        await database.query(table, where: 'id = ?', whereArgs: [id]);
    return data.isNotEmpty;
  }
}
