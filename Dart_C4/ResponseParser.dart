import 'dart:convert';

class ResponseParser {
  parseInfo(var user_response) {
    var info = json.decode(user_response.body);
    return info;
  }
}
