import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/UserList.dart';
import 'package:prototype_your_auction_services/screen/ForgotPassWord.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/screen/Register.dart';

import 'HomePage.dart';

void main() => runApp(YourAuctionServices());

class YourAuctionServices extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}