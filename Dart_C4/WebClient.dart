import 'package:http/http.dart' as http;
import 'ResponseParser.dart';

class WebClient {
  getinfo(var url) async {
    try {
      var response = await http.get(Uri.parse(url));
      ResponseParser parser = new ResponseParser();
      return parser.parseInfo(response);
    } catch (Exception) {
      var response =
          await http.get(Uri.parse('http://cheon.atwebpages.com/c4/info/'));
      ResponseParser parser = new ResponseParser();
      return parser.parseInfo(response);
    }
  }
}
