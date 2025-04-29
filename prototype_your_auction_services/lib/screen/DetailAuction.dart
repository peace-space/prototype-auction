import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/BidLists.dart';
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
          "รายละเอียด: ${ShareProductData.productData['id_auctions']}",
        ),
      ),
        body:
        Container(
          margin: EdgeInsets.all(20),
          child:
          ListView(
            children: [
              Container(
                color: Colors.lightBlueAccent,
                height: 300,
                width: 500,
                child: displayImages(),
              ),
              displayDataAuction(context),
            ],
          ),
      )
    );
  }

  Widget displayDataAuction(BuildContext ctx) {
    return StreamBuilder(
      stream: fetchDataDetailAuctions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR.");
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("เวลา: ",
                      style: headText(),),
                    Text(
                      "18.25.23 วินาที",
                      style: redText(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ราคาสูงสุด: ",
                      style: headText(),),
                    Text(
                      "${snapshot.data!['max_price']}",
                      style: redText(),
                    )
                  ],
                ),
                textButtonGoToBidLists(ctx, snapshot.data!['bids_count']),
                onBit(),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Text(
                        "ผู้เปิดประมูล: ",
                        style: headText()
                    ),
                    Text(
                      "${snapshot.data!['name']}",
                      style: defaultText(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ชื่อสินค้า: ",
                      style: headText(),),
                    Text(
                      "${snapshot.data!['name_product']}",
                      style: defaultText(),)
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "ข้อมูลเพิ่มเติม: ",
                      style: headText(),
                    ),
                  ],
                ),
                Text("${snapshot.data!['detail_product']}",
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.clip,
                  style: defaultText(),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Widget displayDataAuction() {
  //   return Text("data");
  // }

  Widget displayImages() {
    double left = 0.0;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    return StreamBuilder(
      stream: fetchDataDetailAuctions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!['images'].length,
            itemBuilder: (context, index) {
              return Container(
                  width: 353,
                  height: 300,
                  padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                  child:
                  Image.network(
                    'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/'
                        +
                        '${snapshot.data!['images'][index]}'
                    , fit: BoxFit.cover,)
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Stream<Map<String, dynamic>> fetchDataDetailAuctions() async* {
    await Future.delayed(Duration(seconds: 1));
    print('Start.detailAuctions');
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/product-detail/${ShareProductData
        .productData['id_auctions']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    Map<String, dynamic> data = resData['data'];
    print("aaaaaaaaaaaaaaaaaaaa");
    // print(data.toString());
    yield data;
    setState(() {});
    print('End.detialAuctions');
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

  TextStyle headText() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle redText() {
    return TextStyle(
        color: Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.bold
    );
  }

  TextStyle defaultText() {
    return TextStyle(
      fontSize: 16,
    );
  }

  Widget textButtonGoToBidLists(BuildContext ctx, int bids_count) {
    return TextButton(
        onPressed: () => {goToBidLists(ctx)},
        child: Text("ผู้ร่วมประมูล: ${bids_count}")
    );
  }

  void goToBidLists(BuildContext ctx) {
    final route = MaterialPageRoute(
      builder: (ctx) => BidLists(),
    );

    Navigator.push(ctx, route);
  }
}
