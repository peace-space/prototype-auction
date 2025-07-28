import 'package:flutter/material.dart';

class AuctionPrivateHome extends StatefulWidget {
  State<AuctionPrivateHome> createState() {
    return AuctionPrivateHomeState();
  }
}

class AuctionPrivateHomeState extends State<AuctionPrivateHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ประมูลส่วนตัว")),
      body: StreamBuilder(
        stream: null,
        builder:
            (context, snapshot) => ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Card(child: Text("data")),
            ),
      ),
    );
  }
}
