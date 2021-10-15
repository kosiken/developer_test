import 'dart:convert';
import 'dart:io';
import 'package:developer_test/debug.dart';
import 'package:http/http.dart' as http;
import 'package:developer_test/models/json-placeholder-response.dart';

const JsonPlaceholderUrl = "https://jsonplaceholder.typicode.com/todos";

class JsonPlaceholderController {
  JsonPlaceholderController._privateConstructor();
  static final JsonPlaceholderController _instance =
      JsonPlaceholderController._privateConstructor();
  static JsonPlaceholderController get instance => _instance;

  Future<List<JsonPlaceholderApiTodo>> getAllTodos() async {
    List<JsonPlaceholderApiTodo> jsonResponse = [];

    try {
      var response = await http.get(Uri.parse(JsonPlaceholderUrl));
    } catch (e) {}

    return jsonResponse;
  }

  Future<List<JsonPlaceholderApiUser>> getAllUsers() async {
    List<JsonPlaceholderApiUser> jsonResponse = [];

    try {
      var response = await http.get(Uri.parse(JsonPlaceholderUrl + "/users"));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jsonMapList = jsonDecode(response.body);

        jsonResponse =
            List.from(jsonMapList.map(JsonPlaceholderApiUser.fromJSON));

        Debug.log(jsonResponse.first);
      } else {
        throw Exception('Failed to load Users');
      }
    } catch (e) {
      Debug.log(e.toString());
    }

    return jsonResponse;
  }
}
