import 'package:http/http.dart' as http;

class APIRequest {
  static Future<String> getRequest(String url, String token) async {
    String response = "";
    try {
      final responseData =
          await http.get(Uri.parse(url), headers: addHeader(token));
      if (responseData.statusCode == 200) {
        response = responseData.body;
      }
      return response;
    } on Exception catch (_, ex) {
      throw (ex);
    }
  }

  static Future<String> postRequest(
      String url, String token, Map<String, dynamic> body) async {
    String response = "";
    try {
      final responseData = await http.post(Uri.parse(url),
          headers: addHeader(token), body: body);
      if (responseData.statusCode == 200) {
        response = responseData.body;
      }
      return response;
    } on Exception catch (_, ex) {
      throw (ex);
    }
  }

  static Map<String, String> addHeader(String token) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
