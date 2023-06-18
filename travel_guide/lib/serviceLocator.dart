import 'package:shared_preferences/shared_preferences.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  SharedPreferences? _preferences;

  void registerPreferences(SharedPreferences preferences) {
    _preferences = preferences;
  }

  SharedPreferences get preferences {
    assert(_preferences != null, 'Preferences has not been registered');
    return _preferences!;
  }
}
