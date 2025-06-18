import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/screen/AddProduct.dart';
import 'package:prototype_your_auction_services/screen/AuctionListUser.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

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
          openAuctionsButton(context),
          Divider(),
          buttonGoToUserProduct(context),
        ],
      ),
      drawer: createDrawer(context),
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

  Widget buttonGoToUserProduct(BuildContext ctx) {
    return ElevatedButton(
        onPressed: () => goToUserProduct(ctx),
        child: Text("รายการสินค้า")
    );
  }

  void goToUserProduct(BuildContext ctx) {
    {
      final route = MaterialPageRoute(builder: (ctx) => AuctionListUser());

      Navigator.push(ctx, route);
    }
  }
}
