import 'dart:convert';

import 'package:mirathi_book_app/config/base_url.dart';
import 'package:mirathi_book_app/model/authentication_model.dart';
import 'package:mirathi_book_app/sessions/session_manager.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  static final SessionManager sessionManager = SessionManager();

  static Future<Outh2Response> userAuthentication(
      String username, String password) async {
    try {
      String tokenUrl = "$baseUrl/oauth2/access_token";

      final Map<String, String> data = {
        'username': username,
        'password': password,
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'password'
      };

      final http.Response response =
          await http.post(Uri.parse(tokenUrl), body: data);

      if (response.statusCode == 200) {
        final Map<String, dynamic> tokenData = json.decode(response.body);
        final String accessToken = tokenData['access_token'];
        sessionManager.saveAccessToken(accessToken);
        String? sessionToken = await sessionManager.getAccessToken();

        sessionManager.saveIsUserAlreadyLoggedIn(true);

        return Outh2Response(
            accessToken: sessionToken,
            code: response.statusCode,
            message: 'Login Successfully');
      } else {
        return Outh2Response(
            accessToken: null,
            code: response.statusCode,
            message: "Invalid Credentials! Try Again.");
      }
    } catch (e) {
      return Outh2Response(
          accessToken: null,
          message: 'An error occurred during authentication.');
    }
  }

  static Future<Outh2Response> logout() async {
    sessionManager.saveAccessToken('');
    // await sessionManager.clearProfileUniqueId();
    String? sessionToken = await sessionManager.getAccessToken();
    // sessionManager.saveRememberMe(false);
    sessionManager.saveIsUserAlreadyLoggedIn(false);
    return Outh2Response(
        accessToken: sessionToken, message: 'Logout Successfully');
  }
}
