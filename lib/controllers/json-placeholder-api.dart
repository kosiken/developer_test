import 'dart:convert';
import 'package:developer_test/debug.dart';
import 'package:http/http.dart' as http;

const JsonPlaceholderUrl = "https://jsonplaceholder.typicode.com";

class JsonPlaceholderController<T> {
  final T Function(dynamic json) resolver;
  final String attacher;

  JsonPlaceholderController(this.resolver, this.attacher);

  Future<List<T>> getAllT<T>() async {
    List<T> jsonResponse = [];
    // try {
    var response = await http.get(Uri.parse(JsonPlaceholderUrl + attacher));

    if (response.statusCode == 200) {
      // List<dynamic> jsonMapList = ;

      jsonResponse = List.from(jsonDecode(response.body).map(resolver));

      Debug.log(jsonResponse.first);
    } else {
      throw Exception('Failed to load Todos');
    }
    // } catch (e) {
    //   Debug.log(e.toString());
    // }

    return jsonResponse;
  }
}
