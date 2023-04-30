import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoApi {
  static Future<http.Response> getTasks(String authToken) async {
    return await http.get(Uri.parse('http://localhost:9999/api/v1/task'),
        headers: {'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> getTask(String authToken, id) async {
    return await http.get(Uri.parse('http://localhost:9999/api/v1/task/$id'),
        headers: {'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> postTask(String authToken, String description,
      DateTime date, List<int> labelIds) async {
    return await http.post(Uri.parse('http://localhost:9999/api/v1/task'),
        body: json.encode({
          'description': description,
          'date': date.toUtc().toIso8601String(),
          'labelIds': [...labelIds]
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        });
  }

  static Future<http.Response> putTask(
      String authToken, String description, String date, int taskID) async {
    return await http.put(
        Uri.parse('http://localhost:9999/api/v1/task/$taskID'),
        body: json.encode({'description': description, 'date': date}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken'
        });
  }

  static Future<http.Response> deleteTask(String authToken, int id) async {
    return await http.delete(Uri.parse('http://localhost:9999/api/v1/task/$id'),
        headers: {'Authorization': 'Bearer $authToken'});
  }
}
