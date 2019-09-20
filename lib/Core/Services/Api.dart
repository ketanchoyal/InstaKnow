import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instaknown/Core/Services/UrlHelper.dart';
import 'package:instaknown/Core/models/Result.dart';

class Api {
  // String _url = 'http://7755efc4.ngrok.io/requestjson';

  UrlHelper urlHelper = UrlHelper();

  Future<String> _url() async => urlHelper.getNewUrl();

  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Result> getSentimentsPublic(String user) async {
    // await Future.delayed(Duration(seconds: 8));
    var body = json.encode({
      'type': 'Public',
      'login_id': user,
    });

    print(body);

    // String url = await _url();

    final response = await http.post(
      await _url(),
      body: body,
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final jsonData = await json.decode(response.body);
      Result result = Result.fromJson(jsonData);
      return result;
    } else {
      return Result();
    }
  }

  Future<Result> getSentimentsPrivate(
      String username, String password, String user) async {
    var body = json.encode({
      'type': 'Private',
      'login_id': user,
      'login_username': username,
      'password': password
    });

    print(body);

    final response = await http.post(
      await _url(),
      body: body,
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final jsonData = await json.decode(response.body);

      Result result = Result.fromJson(jsonData);
      return result;
    } else {
      return Result();
    }
  }
}
