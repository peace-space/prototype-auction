import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/share/ApiPathLocal.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';

import 'ShareProductData.dart';
import 'ShareUserData.dart';

class Logout {
  final String logout_api_local_get = ApiPathLocal().getLogoutApiLocalGet();
  final String logout_api_server_get = ApiPathServer().getLogoutApiServerGet();

  final BuildContext context;

  Logout({required this.context});

  void onLogout() async {
    try {
      print("\n\n\n\n\n Start onLogout");
      final uri = Uri.parse(logout_api_server_get);

      FlutterSecureStorage storage = FlutterSecureStorage();

      String? user_token = await storage.read(key: 'user_token');
      String? user_token_type = await storage.read(key: 'user_token_type');
      Map<String, String> http_header = {
        HttpHeaders.authorizationHeader:
            user_token_type.toString() + user_token.toString(),
      };
      final response = await get(uri, headers: http_header);
      // storage.deleteAll();
      // ShareData.logedIn = false;
      // ShareData.admin = false;
      // ShareData.userData = {};
      // ShareData.upDateState = () {};
      // ShareProductData.productData = {};

      if (response.statusCode == 200) {
        storage.deleteAll();
        ShareData.logedIn = false;
        ShareData.admin = false;
        ShareData.userData = {};
        ShareData.upDateState = () {};
        ShareProductData.productData = {};
        print("Logout Successfully.");

        Navigator.pushReplacement(
          this.context,
          MaterialPageRoute(builder: (context) => AuctionHome()),
        );
      } else {
        print("Login Error");
        // showDialog(context: context, builder: (context) => AlertDialog(
        //   title: Text("แจ้งเตือน"),
        //   content: Text("เกิดข้อผิดพลาดในการออกจากระบบ"),
        //   actions: [
        //     TextButton(onPressed: () => {
        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuctionHome(),))
        //     }, child: Text("ตกลง"))
        //   ],
        // ),);
      }

      print("StatusCode Logout: " + response.statusCode.toString());
    } on Exception catch (e) {
      print("Error Logout: " + e.toString());
    }

    print("End onLogout\n\n\n\n\n");
  }
}
