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
      body: ListView(
        children: [
          Container(
            color: Colors.lightBlueAccent,
            height: 200,
            child: displayImages(),
          ),
          Container(
            color: Colors.green,
            height: 200,
            child: displayDataAuction(),
          ),
        ],
      )
    );
  }

  Widget displayDataAuction() {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text("test")
            ],
          ),
        );

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget displayImages() {
    return Text("data");
  }
}
