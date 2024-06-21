import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth.dart';

//const String URL = "http://helpital.fr:3000";
const String URL = "http://192.168.1.66:3000";

/// Utils service function for post and get to finish ///
class Utils {
  AuthService authService = AuthService();

  Future<List<Map<String, dynamic>>> get(_path) async {
    var cookies =  await authService.getCookiesJsonify();
    final response = await http.get(Uri.parse('$URL/api/$_path'),
      headers: {
        'Content-Type': 'application/json',
        'cookie': cookies
      },
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed;
    } else {
      return null;
    }
  }

  Future<bool> post(_path, _body) async {
    var cookies =  await AuthService().getCookiesJsonify();

    final response = await http.post(Uri.parse('$URL/api/$_path'),
      headers: {
        'Content-Type': 'application/json',
        'cookie': cookies
      },
      body: _body
    );
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 302) {
      return true;
    } else {
      return false;
    }
  }
}