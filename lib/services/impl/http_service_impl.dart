import 'package:flutter_mqtt/services/ihttp_service.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpServiceImpl implements IHttpService {
  @override
  Future<String> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<String> post(String url, Map<String, dynamic> data) async {
    // https://developers.google.com/books/docs/overview
    var uri = Uri.https(url);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];

      return "";
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "";
    }
  }
}
