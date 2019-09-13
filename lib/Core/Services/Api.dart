import 'package:http/http.dart' as http;
import 'package:instaknown/Core/models/Result.dart';

class Api {
  String _url = '';

  Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Result> getSentimentsPublic(String user) async {}

  Future<Result> getSentimentsPrivate(
      String username, String password, String user) async {}
}
