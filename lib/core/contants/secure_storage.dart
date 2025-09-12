import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SecureStorage {
  static late final FlutterSecureStorage _storage;

  static Future<void> initialize() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );
  }

  static Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (error, stackTrace) {
      _handleError('write', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (error, stackTrace) {
      _handleError('read', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (error, stackTrace) {
      _handleError('delete', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } catch (error, stackTrace) {
      _handleError('clear', error, stackTrace);
      rethrow;
    }
  }

  static Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (error, stackTrace) {
      _handleError('containsKey', error, stackTrace, key: key);
      rethrow;
    }
  }

  static Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (error, stackTrace) {
      _handleError('readAll', error, stackTrace);
      rethrow;
    }
  }

  static void _handleError(
    String operation,
    Object error,
    StackTrace stackTrace, {
    String? key,
  }) {
    log('SecureStorage $operation error${key != null ? " for key: $key" : ""}: $error');
  }
}
