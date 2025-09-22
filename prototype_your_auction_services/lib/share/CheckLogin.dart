import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ApiPathLocal.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

import 'ShareProductData.dart';

class CheckLogin {
  final String check_login_api_local_get =
      ApiPathLocal().getCheckLoginApiLocalGet();
  final String check_login_api_server_get =
      ConfigAPI().getCheckLoginApiServerGet();

  // final BuildContext ctx;

  // CheckLogin();

  // void onCheckLogin() async {
  Future<dynamic> onCheckLogin() async {
    print("Start Check Login");

    // await Future.delayed(Duration(seconds: 2));

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
        if (data['bank_account'] != null) {
          ShareData.bankAccountUser = data['bank_account'];
        }

        ShareData.logedIn = true;
        ShareData.image_user_profile = data['user_data']['image_profile'];

        if (data['user_data']['admin_status'] == '1') {
          ShareData.admin = true;
        } else {
          ShareData.admin = false;
        }

        print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        // await Future.delayed(Duration(seconds: 3));
        return "เข้าสู่ระบบแล้ว";
      } else {
        print("หมดเวลาเข้าสู่ระบบ");
        ShareData.logedIn = false;
        ShareData.userData = {};
        ShareProductData.productData = {};
        return "ยังไม่เข้าสู่ระบบ";
      }
    } else {
      print("Storage No data");
      ShareData.logedIn = false;
      ShareData.userData = {};
      ShareData.bankAccountUser = {};
      ShareProductData.productData = {};
    }

    print("End Check Login");
  }
}
