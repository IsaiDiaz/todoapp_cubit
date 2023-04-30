import 'package:http/http.dart' as http;
import 'dart:convert';

class LabelsApi {
  static Future<http.Response> getLabels(String authToken) async {
    return await http.get(Uri.parse('http://localhost:9999/api/v1/label'), headers: {'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> getLabel(String authToken, int id) async {
    return await http.get(Uri.parse('http://localhost:9999/api/v1/label/$id'), headers: {'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> addLabel(String name, String date, String authToken) async {
    return await http.post(Uri.parse('http://localhost:9999/api/v1/label'), body: json.encode({'name': name, 'date': date}), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> updateLabel(String name, String date, String authToken, int id) async {
    return await http.put(Uri.parse('http://localhost:9999/api/v1/label/$id'), body: {'name': name, 'date' : date}, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $authToken'});
  }

}