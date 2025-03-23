import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuctionHome extends StatefulWidget {
  State<AuctionHome> createState() {
    return AuctionHomeState();
  }
}

class AuctionHomeState extends State<AuctionHome> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
    );
  }
}