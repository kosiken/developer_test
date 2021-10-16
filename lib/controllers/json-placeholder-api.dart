import 'dart:convert';
import 'package:developer_test/debug.dart';
import 'package:http/http.dart' as http;

const JsonPlaceholderUrl = "https://jsonplaceholder.typicode.com";

/// This class is used to send get requests for
/// all the JsonPlaceholder api endpoints
/// Once The template class T is specified during instanstiation
/// then the resultant instance can be used to perform a JsonPlaceholder api get request
/// for results of the T type
/// e.g
///
/// ```dart
/// var controller = JsonPlaceholderController<JsonPlaceholderApiUser>(
///                    JsonPlaceholderApiUser.fromJSON, "/users"),
///              );
/// // controller.getAlll() => Future<List<JsonPlaceholderApiUser>>
///
/// ```
///
/// Only JsonPlaceholderApiUser models can be used as T
class JsonPlaceholderController<T> {
  final T Function(dynamic json) resolver;
  final String attacher;

  JsonPlaceholderController(this.resolver, this.attacher);

  Future<List<T>> getAllT() async {
    List<T> jsonResponse = [];
    try {
      var response = await http.get(Uri.parse(JsonPlaceholderUrl + attacher));

      if (response.statusCode == 200) {
        jsonResponse = List.from(jsonDecode(response.body).map(resolver));

        Debug.log(jsonResponse.first);
      } else {
        throw Exception('Failed to load Todos');
      }
    } catch (e) {
      Debug.log(e.toString());
      throw Exception("An Error Ocurred while trying to complete request");
    }

    return jsonResponse;
  }
}
