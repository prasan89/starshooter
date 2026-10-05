/// SharedPreferences wrapper with typed accessors and JSON helpers.
library;

import 'dart:convert';
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around [SharedPreferences] that provides:
/// - Typed get/set helpers (String, int, bool).
/// - JSON map/list helpers backed by JSON encoding.
/// - Graceful error handling: all methods catch exceptions and return null
///   (for reads) or false (for writes) instead of throwing.
class LocalStorage {
  LocalStorage(this._prefs);

  final SharedPreferences _prefs;

  // ---------------------------------------------------------------------------
  // String
  // ---------------------------------------------------------------------------

  /// Returns the stored string for [key], or null if absent or on error.
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e, st) {
      dev.log('LocalStorage.getString($key) failed', error: e, stackTrace: st);
      return null;
    }
  }

  /// Stores [value] for [key]. Returns false on error.
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e, st) {
      dev.log('LocalStorage.setString($key) failed', error: e, stackTrace: st);
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // int
  // ---------------------------------------------------------------------------

  /// Returns the stored int for [key], or null if absent or on error.
  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e, st) {
      dev.log('LocalStorage.getInt($key) failed', error: e, stackTrace: st);
      return null;
    }
  }

  /// Stores [value] for [key]. Returns false on error.
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e, st) {
      dev.log('LocalStorage.setInt($key) failed', error: e, stackTrace: st);
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // bool
  // ---------------------------------------------------------------------------

  /// Returns the stored bool for [key], or null if absent or on error.
  bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e, st) {
      dev.log('LocalStorage.getBool($key) failed', error: e, stackTrace: st);
      return null;
    }
  }

  /// Stores [value] for [key]. Returns false on error.
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e, st) {
      dev.log('LocalStorage.setBool($key) failed', error: e, stackTrace: st);
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Remove / clear
  // ---------------------------------------------------------------------------

  /// Removes the value stored under [key]. Returns false on error.
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e, st) {
      dev.log('LocalStorage.remove($key) failed', error: e, stackTrace: st);
      return false;
    }
  }

  /// Clears all stored values. Returns false on error.
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e, st) {
      dev.log('LocalStorage.clear() failed', error: e, stackTrace: st);
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // JSON helpers
  // ---------------------------------------------------------------------------

  /// Returns the JSON-decoded map stored under [key], or null on any error.
  Map<String, dynamic>? getJson(String key) {
    try {
      final raw = _prefs.getString(key);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      dev.log(
        'LocalStorage.getJson($key): unexpected type ${decoded.runtimeType}',
      );
      return null;
    } catch (e, st) {
      dev.log('LocalStorage.getJson($key) failed', error: e, stackTrace: st);
      return null;
    }
  }

  /// JSON-encodes [value] and stores it under [key]. Returns false on error.
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final encoded = jsonEncode(value);
      return await _prefs.setString(key, encoded);
    } catch (e, st) {
      dev.log('LocalStorage.setJson($key) failed', error: e, stackTrace: st);
      return false;
    }
  }

  /// Returns the JSON-decoded list of maps stored under [key], or null on error.
  List<Map<String, dynamic>>? getJsonList(String key) {
    try {
      final raw = _prefs.getString(key);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        dev.log(
          'LocalStorage.getJsonList($key): unexpected type ${decoded.runtimeType}',
        );
        return null;
      }
      return decoded.whereType<Map<String, dynamic>>().toList(growable: false);
    } catch (e, st) {
      dev.log(
        'LocalStorage.getJsonList($key) failed',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  /// JSON-encodes [list] and stores it under [key]. Returns false on error.
  Future<bool> setJsonList(
    String key,
    List<Map<String, dynamic>> list,
  ) async {
    try {
      final encoded = jsonEncode(list);
      return await _prefs.setString(key, encoded);
    } catch (e, st) {
      dev.log(
        'LocalStorage.setJsonList($key) failed',
        error: e,
        stackTrace: st,
      );
      return false;
    }
  }
}
