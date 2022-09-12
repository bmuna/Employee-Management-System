import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class LocalData {
  static Future<void> saveUserType(String userType) async {
    var boxName = dotenv.env['EMS_USER_TYPE_BOX'];
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    box.put(boxName, userType);
  }

  static Future<String?> retrieveUserType() async {
    var boxName = dotenv.env['EMS_USER_TYPE_BOX'];
    final box = await Hive.openBox(boxName!);
    String? usertype = await box.get(boxName);
    return usertype;
  }

  static Future<void> deleteUserType() async {
    var boxName = dotenv.env['EMS_USER_TYPE_BOX'];
    final box = await Hive.openBox(boxName!);
    await box.delete(boxName);
  }

  static Future<void> saveAdminToken(String token) async {
    const secureStorage = FlutterSecureStorage();

    try {
      String? boxName = dotenv.env['EMS_ADMIN_BOX'];
      String? storagekey = dotenv.env['ENCRIPTION_ADMINKEY_STORAGE'];

      final encryprionKey = await secureStorage.read(key: storagekey!);
      if (encryprionKey == null) {
        final key = Hive.generateSecureKey();
        await secureStorage.write(
          key: storagekey,
          value: base64UrlEncode(key),
        );
      }
      final key = await secureStorage.read(key: storagekey);
      final encryptionKey = base64Url.decode(key!);
      final encryptedBox = await Hive.openBox(boxName!,
          encryptionCipher: HiveAesCipher(encryptionKey));
      await encryptedBox.put(boxName, token);
    } on Exception catch (e) {
      throw Exception("message: $e");
    }
  }

  static Future<String?> retrieveAdminToken() async {
    const secureStorage = FlutterSecureStorage();

    try {
      String? boxName = dotenv.env['EMS_ADMIN_BOX'];
      String? storagekey = dotenv.env['ENCRIPTION_ADMINKEY_STORAGE'];
      final key = await secureStorage.read(key: storagekey!);
      if (key == null) {
        return null;
      } else {
        final encryptionKey = base64Url.decode(key);
        final encryptedBox = await Hive.openBox(boxName!,
            encryptionCipher: HiveAesCipher(encryptionKey));
        String token = await encryptedBox.get(boxName);
        encryptedBox.close();
        return token;
      }
    } on Exception catch (e) {
      throw Exception("message: $e");
    }
  }

  static Future<void> deleteAdminToken() async {
    const secureStorage = FlutterSecureStorage();

    try {
      String? boxName = dotenv.env['EMS_ADMIN_BOX'];
      String? storagekey = dotenv.env['ENCRIPTION_ADMINKEY_STORAGE'];
      final key = await secureStorage.read(key: storagekey!);
      final encryptionKey = base64Url.decode(key!);
      final encryptedBox = await Hive.openBox(boxName!,
          encryptionCipher: HiveAesCipher(encryptionKey));
      await encryptedBox.delete(boxName);
      encryptedBox.close();
    } on Exception catch (e) {
      throw Exception("message: $e");
    }
  }

  static Future<void> saveUserToken(String token) async {
    const secureStorage = FlutterSecureStorage();

    try {
      String? boxName = dotenv.env['EMS_USER_BOX'];
      String? storagekey = dotenv.env['ENCRIPTION_USERKEY_STORAGE'];
      final encryprionKey = await secureStorage.read(key: storagekey!);
      if (encryprionKey == null) {
        final key = Hive.generateSecureKey();
        await secureStorage.write(
          key: storagekey,
          value: base64UrlEncode(key),
        );
      }
      final key = await secureStorage.read(key: storagekey);
      final encryptionKey = base64Url.decode(key!);
      final encryptedBox = await Hive.openBox(boxName!,
          encryptionCipher: HiveAesCipher(encryptionKey));
      await encryptedBox.put(boxName, token);
    } on Exception catch (e) {
      throw Exception("message: $e");
    }
  }

  static Future<String?> retrieveUserToken() async {
    const secureStorage = FlutterSecureStorage();

    try {
      String? boxName = dotenv.env['EMS_USER_BOX'];
      String? storagekey = dotenv.env['ENCRIPTION_USERKEY_STORAGE'];
      final key = await secureStorage.read(key: storagekey!);
      if (key == null) {
        return null;
      } else {
        final encryptionKey = base64Url.decode(key);
        final encryptedBox = await Hive.openBox(boxName!,
            encryptionCipher: HiveAesCipher(encryptionKey));
        String token = await encryptedBox.get(boxName);
        encryptedBox.close();
        return token;
      }
    } on Exception catch (e) {
      throw Exception("message: $e");
    }
  }

  static Future<void> deleteUserToken() async {
    const secureStorage = FlutterSecureStorage();

    try {
      String? boxName = dotenv.env['EMS_USER_BOX'];
      String? storagekey = dotenv.env['ENCRIPTION_USERKEY_STORAGE'];
      final key = await secureStorage.read(key: storagekey!);
      final encryptionKey = base64Url.decode(key!);
      final encryptedBox = await Hive.openBox(boxName!,
          encryptionCipher: HiveAesCipher(encryptionKey));
      await encryptedBox.delete(boxName);
      encryptedBox.close();
    } on Exception catch (e) {
      throw Exception("message: $e");
    }
  }

  static Future<void> saveUserRoleId(int roleId) async {
    var boxName = dotenv.env['EMS_USER_ROLE_ID'];
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    box.put(boxName, roleId);
  }

  static Future<int?> retrieveRoleId() async {
    var boxName = dotenv.env['EMS_USER_ROLE_ID'];
    final box = await Hive.openBox(boxName!);
    int? roleId = await box.get(boxName);
    return roleId;
  }

  static Future<void> deleteRoleId() async {
    var boxName = dotenv.env['EMS_USER_ROLE_ID'];
    final box = await Hive.openBox(boxName!);
    await box.delete(boxName);
  }
}
