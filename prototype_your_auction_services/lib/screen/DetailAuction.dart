import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/share_data/ShareProductData.dart';

class DetailAuction extends StatefulWidget {
  State<DetailAuction> createState() {
    return DetailAuctionState();
  }
}

class DetailAuctionState extends State<DetailAuction> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียด: ${ShareProductData.productData['name_product']}",
        ),
      ),
      body: Text("data"),
    );
  }
}
