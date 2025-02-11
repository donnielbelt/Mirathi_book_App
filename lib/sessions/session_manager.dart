// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  Future<bool?> isUserAlreadyLoggedIn() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getBool('user_already_logged_in');
    String loggedMe = await storage.read(key: "user_already_logged_in") ?? "false";
    bool status = false;
    if (loggedMe == "true") {
      status = true;
    }
    return status;
  }

  void saveIsUserAlreadyLoggedIn(bool status) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // preferences.setBool('user_already_logged_in', status);
    String loggedStatus = "false";
    if (status) {
      loggedStatus = "true";
    }
    storage.write(key: "user_already_logged_in", value: loggedStatus);
  }

  void saveAccessToken(String token) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // preferences.setString('user_access_token', token);
    storage.write(key: 'user_access_token', value: token);
  }

  Future<String?> getAccessToken() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getString('user_access_token');
    return storage.read(key: 'user_access_token');
  }

  void saveRefreshToken(String refreshToken) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // preferences.setString('refresh_token', refreshToken);
    storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<String?> getRefreshToken() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getString('refresh_token');
    return storage.read(key: 'refresh_token');
  }


  Future<bool> isRefreshTokenExpired() async {
    final String? refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      // Refresh token not found, consider it expired
      return true;
    }

    List<String> tokenParts = refreshToken.split('.');
    if (tokenParts.length != 3) {
      // Invalid token format, consider it expired
      return true;
    }

    // Get the payload part of the token and decode it
    String payload = tokenParts[1];
    String decodedPayload = utf8.decode(base64Url.decode(base64Url.normalize(payload)));

    Map<String, dynamic> tokenPayload = jsonDecode(decodedPayload);
    final int expirationTime = tokenPayload['exp'];

    // Calculate the current time in seconds since the Unix epoch
    final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Check if the current time is after the expiration time
    return currentTime > expirationTime;
  }


  Future<bool> isTokenExpired() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String? tokenPayloadString = await storage.read(key: 'token_expiration');
    if (tokenPayloadString == null) {
      // Token payload information is not available, consider it expired
      return true;
    }

    Map<String, dynamic> tokenPayload = jsonDecode(tokenPayloadString);
    final int expirationTime = tokenPayload['exp'];
    final int originalIssuedAt = tokenPayload['origIat'];

    // Calculate the current time in seconds since the Unix epoch
    final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Check if the current time is after the expiration time
    return currentTime > expirationTime;
  }


  void saveRememberMe(bool status) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // preferences.setBool('remember_me_checked', status);
    String rememberStatus = "false";
    if (status) {
      rememberStatus = "true";
    }
    storage.write(key: "remember_me_checked", value: rememberStatus);
  }

  Future<bool?> getRememberMe() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getBool('remember_me_checked');
    String rememberMe = await storage.read(key: "remember_me_checked") ?? "false";
    bool status = false;
    if (rememberMe == "true") {
      status = true;
    }
    return status;
  }


  void saveUsername(String username) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // preferences.setString('username', username);
    storage.write(key: 'username', value: username);
  }

  Future<String?> getUsername() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getString('username');
    return storage.read(key: 'username');
  }

  void saveLanguage(String language) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('language', language);
    storage.write(key: 'language', value: language);
  }

  Future<String?> getLanguage() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('language');
    return storage.read(key: 'language');
  }

  void savePassword(String username) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // preferences.setString('password', username);
    storage.write(key: 'password', value: username);
  }

  Future<String?> getPassword() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getString('password');
    return storage.read(key: 'password');
  }

  Future<String?> getProfileId() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final preferences = await SharedPreferences.getInstance();
    // return preferences.getString('profileId');
    return storage.read(key: 'profileId');
  }

  void saveWhiteMode(bool whiteMode) async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool('white_mode', whiteMode);
    String whiteStatus = "true";
    if(whiteMode){
      whiteStatus = "false";
    }
    storage.write(key: 'white_mode', value: whiteStatus);
  }

  Future<void> logout() async {
    saveIsUserAlreadyLoggedIn(false);
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final FlutterSecureStorage storage =  FlutterSecureStorage(aOptions: getAndroidOptions());
    storage.delete(key: 'user_access_token');
    storage.delete(key: 'refresh_token');
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
  }
}
