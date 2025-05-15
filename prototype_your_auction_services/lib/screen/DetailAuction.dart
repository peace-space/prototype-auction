import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/BidLists.dart';
import 'package:prototype_your_auction_services/share_data/ShareProductData.dart';
import 'package:prototype_your_auction_services/share_data/ShareUserData.dart';
// import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class DetailAuction extends StatefulWidget {
  State<DetailAuction> createState() {
    return DetailAuctionState();
  }
}

class DetailAuctionState extends State<DetailAuction> {
  var _bit = TextEditingController();
  Map<String, dynamic> detailAuctionData = {};

  var _countDownDateTime = '-';

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
    // print(_countDownDateTime);
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
                    countdown(),
                    Text(
                      " วินาที",
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
                TimerCountdown(
                  endTime: DateTime(2025, 5, 7, 21, 07, DateTime
                      .now()
                      .second),
                  onEnd: () {
                    print("EEEEEEEEEEEEEEEE");
                  },),

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
    // countdown();
    yield data;
    setState(() {
      detailAuctionData = data;
    });
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
              onPressed: () =>
              {
                submitOnBidding()
              },
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

  void submitOnBidding() async {
    print("Start.");
    try {
      print(ShareData.userData['id_users']);
      print(ShareProductData.productData['id_auctions']);
      if (ShareData.userData['id_users'] != null) {
        Map<String, dynamic> data = {
          'id_users': ShareData.userData['id_users'],
          'id_auctions': ShareProductData.productData['id_auctions'],
          'bid_price': _bit.text
        };

        String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/bidding';
        final uri = Uri.parse(url);
        final responce = await http.post(
          uri,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );

        final reActions = jsonDecode(responce.body);

        if (responce.statusCode == 200) {
          print("Successfully: " + responce.statusCode.toString());
        } else {
          print("Error: " + responce.statusCode.toString());
        }
      } else {
        print('กรุณาเข้าสู่ระบบ');
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
    print("End.");
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

  // bool compareCurrentDateTimeAndEndDateTime(DateTime date_time_curent, DateTime end_date_time) {
  //   if ()
  //   return true;
  // }

  Widget countdown() {
    final start_date_time_data = detailAuctionData['start_date_time'];
    final end_date_time_data = detailAuctionData['end_date_time'];

    // print(detailAuctionData.toString());
    var min;
    var end_date_time = DateTime.parse(end_date_time_data);

    var date_tiem_difference = end_date_time.difference(DateTime.now());
    // print("aaaaaaaaaaaaaaa: " + date_tiem_difference.toString());
    var countdown = TimerCountdown(
      endTime: DateTime.now().add(
          Duration(seconds: date_tiem_difference.inSeconds)),
      onTick: (value) =>
      {
        setState(() {
          String hour = value.inHours.toString();
          min = value.inMinutes.toString();
          // String sec = value.inSeconds.toString();
          _countDownDateTime =
              hour.toString() + ":" + min.toString() + ":" + "00";
        })
      },
      format: CountDownTimerFormat.daysHoursMinutesSeconds,
      enableDescriptions: true,
      spacerWidth: 5,
      timeTextStyle: TextStyle(
        fontSize: 36,
        color: Colors.red,
        height: 0,
      ),
      daysDescription: "day",
      hoursDescription: "hour",
      minutesDescription: "min",
      secondsDescription: "sec",
      descriptionTextStyle: TextStyle(
        height: 0,
      ),
      colonsTextStyle: TextStyle(
          fontSize: 36,
          color: Colors.red
      ),
    );
    // print("aaaaaaaaaaa: " + );
    return countdown;
  }

// void test() {
//   TimerCountdown(endTime: DateTime(2025, 5, 7, 21, 02, DateTime.now().second), onEnd: () {
//     print("EEEEEEEEEEEEEEEE");
//   },);
// }
}

