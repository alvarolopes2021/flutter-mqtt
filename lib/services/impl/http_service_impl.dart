import 'dart:convert';
import 'dart:io';

import 'package:flutter_mqtt/services/ihttp_service.dart';

import 'package:http/http.dart' as http;

class HttpServiceImpl implements IHttpService {
  @override
  Future<String> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<String> post(
      String url, String route, Map<String, dynamic> data) async {
    // https://developers.google.com/books/docs/overview
    var uri = Uri.http(url, route);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(uri,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json.encode(data));

    if (response.statusCode == 200) {
      var body = json.decode(response.body) as Map;
      print(response.body);
      if(body.isEmpty){
        return "";
      }

      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return "";
    }
  }
}
