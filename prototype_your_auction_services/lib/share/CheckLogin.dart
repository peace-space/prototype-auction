import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ApiPathLocal.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class CheckLogin {
  final String check_login_api_get = ApiPathLocal().check_login_api_local_get;

  // final BuildContext ctx;

  // CheckLogin();

  void onCheckLogin() async {
    print("Start Check Login");
    final uri = Uri.parse(check_login_api_get);
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? user_token = await storage.read(key: 'user_token');
    String? user_token_type = await storage.read(key: 'user_token_type');
    Map<String, String> http_header = {
      'Authorisation': user_token_type.toString() + user_token.toString(),
    };
    final response = await http.get(uri, headers: http_header);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      Map<String, dynamic> data = responseData['data'];

      ShareData.userData = data;
      ShareData.logedIn = true;

      // showDialog(context: ctx, builder: (context) => AlertDialog(
      //   title: Text(response.statusCode.toString()),
      // ),);

      if (data['admin_status'] == '1') {
        ShareData.admin = true;
      } else {
        ShareData.admin = false;
      }
    } else {
      ShareData.logedIn = false;
    }

    print("End Check Login");
  }
}
