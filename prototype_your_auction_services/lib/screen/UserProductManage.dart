import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AuctionListUser.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

import 'BidLists.dart';

class UserProductManage extends StatefulWidget {
  State<UserProductManage> createState() {
    return UserProductManageState();
  }
}

class UserProductManageState extends State<UserProductManage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShareProductData.productData['name_product']),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              color: Colors.lightBlueAccent,
              height: 300,
              width: 500,
              child: displayImages(),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonDeleteProduct(),
              ],
            ),
            Divider(),
            displayDataAuction(context),
          ],
        ),
      ),
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
          return Center(child: CircularProgressIndicator());
        }

        // if (snapshot.hasData) {
        //   return Text(ShareProductData.productData.toString());
        // }

        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("เวลา: ", style: headText()),
                    countdown(),
                    Text(" วินาที", style: redText()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ราคาสูงสุด: ", style: headText()),
                    Text("${snapshot.data!['max_price']}", style: redText()),
                  ],
                ),
                textButtonGoToBidLists(ctx, snapshot.data!['bids_count']),
                // onBit(),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("ผู้เปิดประมูล: ", style: headText()),
                    Text("${snapshot.data!['name']}", style: defaultText()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("ชื่อสินค้า: ", style: headText()),
                    Text(
                      "${snapshot.data!['name_product']}",
                      style: defaultText(),
                    ),
                  ],
                ),
                Row(children: [Text("ข้อมูลเพิ่มเติม: ", style: headText())]),
                Text(
                  "${snapshot.data!['detail_product']}",
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.clip,
                  style: defaultText(),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

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
                child: Image.network(
                  'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public/' +
                      '${snapshot.data!['images'][index]}',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Stream<Map<String, dynamic>> fetchDataDetailAuctions() async* {
    await Future.delayed(Duration(seconds: 1));
    // print('Start.detailAuctions');
    String url =
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/product-detail/${ShareProductData
        .productData['id_auctions']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    Map<String, dynamic> data = resData['data'];
    // print("aaaaaaaaaaaaaaaaaaaa");
    // print(data.toString());
    // countdown();
    yield data;
    setState(() {});
    // print('End.detialAuctions');
  }

  TextStyle headText() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }

  TextStyle redText() {
    return TextStyle(
      color: Colors.red,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle defaultText() {
    return TextStyle(fontSize: 16);
  }

  Widget countdown() {
    final start_date_time_data = ShareProductData
        .productData['start_date_time'];
    final end_date_time_data = ShareProductData.productData['end_date_time'];

    // print(detailAuctionData.toString());
    print(end_date_time_data.toString());
    var min;
    var end_date_time = DateTime.parse(end_date_time_data);

    var date_tiem_difference = end_date_time.difference(DateTime.now());
    // print("aaaaaaaaaaaaaaa: " + date_tiem_difference.toString());
    var countdown = TimerCountdown(
      endTime: DateTime.now().add(
        Duration(seconds: date_tiem_difference.inSeconds),
      ),
      format: CountDownTimerFormat.daysHoursMinutesSeconds,
      enableDescriptions: true,
      spacerWidth: 5,
      timeTextStyle: TextStyle(fontSize: 21, color: Colors.red, height: 0),
      daysDescription: "day",
      hoursDescription: "hour",
      minutesDescription: "min",
      secondsDescription: "sec",
      descriptionTextStyle: TextStyle(height: 0),
      colonsTextStyle: TextStyle(fontSize: 21, color: Colors.red),
    );
    // print("aaaaaaaaaaa: " + );
    return countdown;
  }

  Widget textButtonGoToBidLists(BuildContext ctx, int bids_count) {
    return TextButton(
      onPressed: () => {goToBidLists(ctx)},
      child: Text("ผู้ร่วมประมูล: ${bids_count}"),
    );
  }

  void goToBidLists(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (ctx) => BidLists());

    Navigator.push(ctx, route);
  }


  Widget buttonDeleteProduct() {
    return ElevatedButton(
        onPressed: () =>
        (
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text("ลบสินค้า"),
                    content: Text("ยืนยันการลบสินค้า ชื่อ: ${ShareProductData
                        .productData['name_product']}",
                      style: TextStyle(
                          fontSize: 16
                      ),),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel', style: TextStyle(fontSize: 18)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onUserProductDelete();
                        },
                        child: Text('OK', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
            )
        ),
        child: Text("ยกเลิกการเปิดประมูล")
    );
  }

  void onUserProductDelete() async {
    print(ShareData.userData['id_users']);
    print(ShareProductData.productData['id_auctions']);
    String url = "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/user-procuct-delete/${ShareData
        .userData['id_users']}/${ShareProductData.productData['id_auctions']}";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserProduct(),));
      print("Successfully.");
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("ลบสินค้าล้มเหลว"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
      );
      throw Exception('Failed');
    }
  }

}