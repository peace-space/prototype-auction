import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';

class UserController {
  Future<Map<String, dynamic>> fetchUserListData() async {
    String url = ConfigAPI().getUserListAdmin();
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    Map<String, dynamic> resData = jsonDecode(response.body);
    // print("CONTROLLER:: ${resData}");
    return resData;
  }

  Future<Map> fetchOneUserDetail({required var id_users}) async {
    print("aaaa");
    String url = ConfigAPI().getOneUserApi(id_users: id_users);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    // print(resData['data'].toString());
    final data = resData['data'];
    print("SSSSSS" + data.toString());
    return data;
    print("bbbb");
  }
}
