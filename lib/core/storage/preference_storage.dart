import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../basic_features.dart';

class PreferenceStorage {
  const PreferenceStorage._();

  static final GetStorage _storage = GetStorage();

  //  First Location Permission
  static bool getFirstPermissionLocation() =>
      _storage.read<bool>("FirstPermissionLocation") ?? false;

  static Future<bool?> setFirstPermissionLocation(bool value) async {
    try {
      await _storage.write("FirstPermissionLocation", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  //  First Camera Permission
  static bool getFirstPermissionCamera() =>
      _storage.read<bool>("FirstPermissionCamera") ?? false;

  static Future<bool?> setFirstPermissionCamera(bool value) async {
    try {
      await _storage.write("FirstPermissionCamera", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  //  First Contact Permission
  static bool getFirstPermissionContact() =>
      _storage.read<bool>("FirstPermissionContact") ?? false;

  static Future<bool?> setFirstPermissionContact(bool value) async {
    try {
      await _storage.write("FirstPermissionContact", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  //  First Photo Permission
  static bool getFirstPermissionPhoto() =>
      _storage.read<bool>("FirstPermissionPhoto") ?? false;

  static Future<bool?> setFirstPermissionPhoto(bool value) async {
    try {
      await _storage.write("FirstPermissionPhoto", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  //  First Microphone Permission
  static bool getFirstPermissionMicroPhone() =>
      _storage.read<bool>("FirstPermissionMicroPhone") ?? false;

  static Future<bool?> setFirstPermissionMicroPhone(bool value) async {
    try {
      await _storage.write("FirstPermissionMicroPhone", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  //  First Storage Permission
  static bool getFirstPermissionStorage() =>
      _storage.read<bool>("FirstPermissionStorage") ?? false;

  static Future<bool?> setFirstPermissionStorage(bool value) async {
    try {
      await _storage.write("FirstPermissionStorage", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  //  Login Status
  static bool getIsUserLoggedIn() =>
      _storage.read<bool>("IsUserLoggedIn") ?? false;

  static Future<bool?> setIsUserLoggedIn(bool value) async {
    try {
      await _storage.write("IsUserLoggedIn", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Show Welcome Screen
  static bool getShowWelcomeScreen() =>
      _storage.read<bool>("showWelcomeScreen") ?? true;

  static Future<bool?> setShowWelcomeScreen(bool value) async {
    try {
      await _storage.write("showWelcomeScreen", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Current Latitude
  static String getCurrentLatitude() =>
      _storage.read<String>("CurrentLatitude") ?? "0.0";

  static Future<bool?> setCurrentLatitude(String value) async {
    try {
      await _storage.write("CurrentLatitude", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // Current Longitude
  static String getCurrentLongitude() =>
      _storage.read<String>("CurrentLongitude") ?? "0.0";

  static Future<bool?> setCurrentLongitude(String value) async {
    try {
      await _storage.write("CurrentLongitude", value);
      return true;
    } catch (error) {
      return null;
    }
  }

  // For FCM token
  static Future<bool?> setFcmToken(String value) async {
    try {
      await _storage.write("FcmToken", value);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  static Future<String?> getFcmToken() async {
    return _storage.read<String>("FcmToken");
  }

  // For token
  static Future<bool?> setToken(String value) async {
    try {
      await _storage.write("Token", value);
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  static Future<String> getToken() async {
    return _storage.read<String>("Token") ?? '';
  }

  // For String
  static void setString(String key, String value) => _storage.write(key, value);

  static String? getString(String key) => _storage.read<String>(key);

  // For int
  static void setInt(String key, int value) => _storage.write(key, value);

  static int? getInt(String key) => _storage.read<int>(key);

  // For double
  static void setDouble(String key, double value) => _storage.write(key, value);

  static double? getDouble(String key) => _storage.read<double>(key);

  // For bool
  static void setBool(String key, bool value) => _storage.write(key, value);

  static bool? getBool(String key) => _storage.read<bool>(key);

  // For object
  static Future<bool?>? putObject(String key, Object value) async {
    try {
      await _storage.write(key, jsonEncode(value));
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  static Future<Object?>? getObject(String key) async {
    try {
      String? json = _storage.read<String>(key);
      if (json == null) {
        return null;
      }
      return jsonDecode(json);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // To check if key has a value
  static bool hasData(String key) => _storage.hasData(key);

  // To Remove Particular Key
  static void removeValue(String key) => _storage.remove(key);

  // To Clear All Prefs
  static void clearStorage() => _storage.erase();
}
