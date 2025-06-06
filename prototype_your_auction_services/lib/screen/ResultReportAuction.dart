import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AppBar.dart';

class ReportAuction extends StatefulWidget {
  State<ReportAuction> createState() {
    return ReportAuctionState();
  }
}

class ReportAuctionState extends State<ReportAuction> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายงานการประมูล')),
      body: display(),
      drawer: createDrawer(context),
    );
  }

  Widget display() {
    return StreamBuilder(
      stream: null,
      builder:
          (context, snapshot) => ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: 5,
            itemBuilder:
                (context, index) => Card(child: ListTile(title: Text('test'))),
          ),
    );
  }
}
