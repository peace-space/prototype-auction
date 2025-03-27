import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/share_data/ShareProductData.dart';

class DetailAuction extends StatefulWidget {
  State<DetailAuction> createState() {
    return DetailAuctionState();
  }
}

class DetailAuctionState extends State<DetailAuction> {
  var _bit = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียด: ${ShareProductData.productData['name_product']}",
        ),
      ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
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
              Container(
                color: Colors.amberAccent,
                height: 200,
                child: onBit(),
              ),
            ],
          ),
      )
    );
  }

  Widget displayDataAuction() {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("เวลา"),
              Text("ราคาสูงสุด: "),
              Row(
                children: [
                  Text("ชื่อสินค้า: "),
                  Text("Test"),
                  SizedBox(width: 90,),
                  Column(
                    children: [
                      Text("data")
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text("ผู้เปิดประมูล: "),
                  Column(
                    children: [
                      Text("a")
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text("ข้อมูลเพิ่มเติม: ",
                    overflow: TextOverflow.clip,
                  )
                ],
              )
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
    return Text("Image");
  }

  Widget onBit() {
    return Column(
      children: [
        SizedBox(
          // height: 200,
          width: 200,
          child: TextField(
            style: TextStyle(),
            controller: _bit,
            decoration: InputDecoration(
              hintText: "เสนอราคา",
            ),
          ),
        ),
        SizedBox(height: 20,),
        SizedBox(
          width: 110,
          height: 30,
          child: ElevatedButton(
              style: ButtonStyle(),
              onPressed: () => {},
              child: Text("เสนอราคา")
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ],
        )
      ],
    );
  }
}
