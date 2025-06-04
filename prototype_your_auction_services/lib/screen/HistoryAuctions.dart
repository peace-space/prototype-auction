import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';

class HistoryAuctions extends StatefulWidget {
  State<HistoryAuctions> createState() {
    return HistoryAuctionsState();
  }
}

class HistoryAuctionsState extends State<HistoryAuctions> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ประวัติการประมูล")),
      body: display(),
      drawer: createDrawer(context),
    );
  }

  Widget display() {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Card(child: Text("test")),
          ),
        );
      },
    );
  }
}
