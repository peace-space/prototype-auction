import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AddProduct.dart';

class StoreManage extends StatefulWidget {
  State<StoreManage> createState() {
    return StoreManageState();
  }
}

class StoreManageState extends State<StoreManage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("จัดการร้านค้า")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(children: [openAuctionsButton(context)]),
        ],
      ),
    );
  }

  Widget openAuctionsButton(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => goToOpenAuctionButton(ctx),
      child: Text("เปิดประมูล"),
    );
  }

  void goToOpenAuctionButton(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (ctx) => AddProduct());

    Navigator.push(ctx, route);
  }
}
