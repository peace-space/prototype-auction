import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class UserController {
  Future<Map<String, dynamic>> fetchUserData() async {
    String url = ConfigAPI().getUserListAdmin();
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    Map<String, dynamic> resData = jsonDecode(response.body);
    // print("CONTROLLER:: ${resData}");
    return resData;
  }
}
