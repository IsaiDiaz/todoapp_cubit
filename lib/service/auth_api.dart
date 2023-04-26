import 'package:http/http.dart' as http;

class AuthApi {
  static Future<http.Response> login(String userName, String password,) async {
    return await http.post(Uri.parse('http://localhost:9999/api/v1/auth/login'), body: {'username': userName, 'password': password}, headers: {'Content-Type': 'application/json'});
  }

  static Future<http.Response> refresh(String refreshToken) async {
    return await http.post(Uri.parse('http://localhost:9999/api/v1/auth/refresh'), body: {'refreshToken': refreshToken}, headers: {'Content-Type': 'application/json'});
  }
}