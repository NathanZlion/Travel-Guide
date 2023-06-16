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
      id INTEGER PRIMARY KEY NOT NULL, name TEXT, location TEXT, description TEXT,
      image TEXT, rating REAL, thingsToDo TEXT, map TEXT
    )
    ''');

    // creating hotels cart table
    await database.execute('''
    CREATE TABLE hotelCart (
      id INTEGER PRIMARY KEY NOT NULL, name TEXT, location TEXT,
      description TEXT, image TEXT
    )
    ''');

    // the restaurant cart table
    await database.execute('''
    CREATE TABLE restaurantCart (
      id INTEGER PRIMARY KEY NOT NULL, name TEXT, location TEXT,
      description TEXT, image TEXT, rating REAL
    )
    ''');
  }

  static Future<void> insertHotel(Hotel hotel, sql.Database database) {
    return _insertData(database, 'hotelCart', hotel.toMap());
  }

  static Future<void> insertRestaurant(
      Restaurant restaurant, sql.Database database) {
    return _insertData(database, 'restaurantCart', restaurant.toMap());
  }

  static Future<void> insertDestination(
      Destination destination, sql.Database database) {
    return _insertData(database, 'destinationCart', destination.toMap());
  }

  static Future<int> _insertData(
      sql.Database database, String table, Map<String, dynamic> data) async {
    return await database.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getAllData(
      sql.Database database, String table) async {
    return await database.query(table);
  }

  static Future<void> deleteHotel(sql.Database database, int id) async {
    await _deleteData(database, 'hotelCart', id);
  }

  static Future<void> deleteRestaurant(sql.Database database, int id) async {
    await _deleteData(database, 'restaurantCart', id);
  }

  static Future<void> deleteDestination(sql.Database database, int id) async {
    await _deleteData(database, 'destinationCart', id);
  }

  static Future<int> _deleteData(
      sql.Database database, String table, int id) async {
    return await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
