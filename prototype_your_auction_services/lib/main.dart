import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/HomePage.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';

void main() => runApp(YourAuctionServices());

class YourAuctionServices extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: AuctionHome(),
      home: HomePage(),
    );
  }
}