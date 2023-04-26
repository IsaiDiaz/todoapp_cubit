import 'package:http/http.dart' as http;

class TodoApi{
  static Future<http.Response> getTasks(String authToken) async{
    return await http.get(Uri.parse('http://localhost:9999/api/v1/task'), headers: {'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> postTask(String authToken, String description, String date, String labelIds) async {
    return await http.post(Uri.parse('http://localhost:9999/api/v1/task'), body: {'description': description, 'date': date, 'labelIds': labelIds}, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $authToken'});
  }

  static Future<http.Response> putTask(String authToken, String description, String date, int taskID) async {
    return await  http.put(Uri.parse('http://localhost:9999/api/v1/task/$taskID'), body: {'description': description, 'date': date}, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $authToken'});
  }

}