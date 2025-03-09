import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/EditUserProfile.dart';

import 'HomePage.dart';

void main() => runApp(YourAuctionServices());

class YourAuctionServices extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}