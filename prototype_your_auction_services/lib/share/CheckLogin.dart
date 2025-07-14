import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ApiPathLocal.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

import 'ShareProductData.dart';

class CheckLogin {
  final String check_login_api_local_get =
      ApiPathLocal().getCheckLoginApiLocalGet();
  final String check_login_api_server_get =
      ApiPathServer().getCheckLoginApiServerGet();

  // final BuildContext ctx;

  // CheckLogin();

  void onCheckLogin() async {
    print("Start Check Login");
    FlutterSecureStorage storage = FlutterSecureStorage();

    String? user_token = await storage.read(key: 'user_token');
    String? user_token_type = await storage.read(key: 'user_token_type');

    if (user_token != null) {
      final uri = Uri.parse(check_login_api_server_get);

      // print("aaaaaaaaaaaaaaaaaaaaaaa: " + user_token.toString());
      Map<String, String> http_header = {
        HttpHeaders.authorizationHeader:
            user_token_type.toString() + user_token.toString(),
      };
      // print(http_header);
      final response = await http.get(uri, headers: http_header);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic> data = responseData['data'];
        print(responseData['message']);

        ShareData.userData = data['user_data'];
        ShareData.bankAccountUser = data['bank_account'];
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
        print("หมดเวลาเข้าสู่ระบบ");
        ShareData.logedIn = false;
        ShareData.userData = {};
        ShareData.upDateState = () {};
        ShareProductData.productData = {};
      }
    } else {
      print("Storage No data");
      ShareData.logedIn = false;
      ShareData.userData = {};
      ShareData.upDateState = () {};
      ShareProductData.productData = {};
    }

    print("End Check Login");
  }
}
