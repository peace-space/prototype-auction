import 'dart:async';
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
                      "${countdown()} วินาที",
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
    // print('Start.detailAuctions');
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/product-detail/${ShareProductData
        .productData['id_auctions']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    Map<String, dynamic> data = resData['data'];
    // print("aaaaaaaaaaaaaaaaaaaa");
    // print(data.toString());
    yield data;
    setState(() {});
    // print('End.detialAuctions');
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

  String countdown() {
    var date_time_curent = DateTime.now();

    var test = DateTime.parse('2025-05-06 21:59:00');
    print(date_time_curent.toString());
    // String test = '2025-05-06 14:18:00';

    var hour_difference = test.hour - date_time_curent.hour;
    var min_difference = test.minute - date_time_curent.minute;
    var sec_difference = date_time_curent.second;

    // var hour = test.difference(date);
    // var min = 59 - date.minute;
    // int sec = 59 - sec_difference;

    var countDown = test.difference(date_time_curent);
    // var countDown = date.difference(test);

    // print("Days: " + countDown.inDays.toString());
    // print("Hours: " + countDown.inHours.toString());
    // print("Minutes: " + countDown.inMinutes.toString());
    // print("Seconds: " + countDown.inSeconds.toString());

    print("Days: ${test.day.toInt() - date_time_curent.day.toInt()}");
    print("Hours: ${test.hour.toInt() - date_time_curent.hour.toInt()}");
    print("Minutes: ${test.minute.toInt() - date_time_curent.minute.toInt()}");
    print("Seconds: ${60 - date_time_curent.second.toInt()}");
    // print("Seconds: " + countDown.inSeconds.toString());
    int day = test.day.toInt() - date_time_curent.day.toInt();
    int hour = test.hour.toInt() - date_time_curent.hour.toInt();
    int min = test.minute.toInt() - date_time_curent.minute.toInt();
    int sec = 59 - date_time_curent.second.toInt();

    if (day > 0) {
      return day.toString() + "วัน";
    } else if (hour > 0) {
      return hour.toString() + ":"
          + min.toString() + ":"
          + sec.toString();
    } else if (hour <= 0 && min > 0) {
      return "00" + ":"
          + min.toString() + ":"
          + sec.toString();
    } else {
      return "Timeout";
    }

    return "Error.";

    // return "{test} วัน "
    //       + "A" + ":"
    //       + "B" + ":"
    //       + "C";
  }
}

