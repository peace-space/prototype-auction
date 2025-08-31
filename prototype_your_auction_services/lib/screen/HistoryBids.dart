import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

class HistoryAuctions extends StatefulWidget {
  State<HistoryAuctions> createState() {
    return HistoryAuctionsState();
  }
}

class HistoryAuctionsState extends State<HistoryAuctions> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ประวัติการประมูล")),
      body: display(),
      drawer: createDrawer(context),
    );
  }

  Widget display() {
    return StreamBuilder(
      stream: fetchHistoryAuctions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error.'),
          );
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data?[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      '${ConfigAPI().getImageAuctionApiServerGet(
                          image_auction_path: data['image_path_1'])}',
                      cacheHeight: 1000,
                      cacheWidth: 900,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(data.toString()),
                        Text("วันที่เวลา: ${data['created_at'].toString()}"),
                        Text("ชื่อ: ${data['name_product']}"),
                        Text(
                          'จำนวนเงิน: ${data['bid_price'].toString()} บาท',
                          style: TextStyle(fontSize: 13),
                        ),
                        buttonDeleteBid(data['id_bids'], data['id_auctions'],
                            data['end_date_time']),
                      ],
                    ),
                    // trailing: Column(
                    //   children: [Column(
                    //     children: [
                    //       Text(data['created_at'].toString()),
                    //     ],
                    //   )
                    //   ],
                    // ),
                  ),
                );
              }),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );

      },
    );
  }


  Stream<dynamic> fetchHistoryAuctions() async* {
    // print('Start.');
    // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/history-product/${}';
    String url = ConfigAPI().getHistoryProduct(id_users: ShareData
        .userData['id_users']);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data['data']);
      yield data['data'];
      // setState(() {});
    }

    setState(() {});
    // print("End.");
  }

  Widget buttonDeleteBid(var id_bids, var id_auctions, String end_date_time) {
    // print(end_date_time.toString());

    // end_date_time = '2025-07-27 18:35:00';

    // print("Cuurent Date Time: ${DateTime.now()}");
    var date_time = DateTime.parse(end_date_time);
    var check_date_time = date_time.difference(DateTime.now());
    // print(":::::::::::::::::: ${check_date_time.inMinutes}");

    if (check_date_time >= Duration(minutes: 30)) {
      return OutlinedButton(onPressed: () {
        showDialog(context: context, builder: (context) =>
            AlertDialog(
              title: Text("ยืนยันการลบ"),
              content: Text(
                  "หากลบข้อมูลการประมูลจะหายไป\nแม้ว่าราคาที่คุณเสนอจะสูงที่สุดก็ตาม\nคุณยืนยันที่จะลบหรือไม่ ??"),
              actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text("ยกเลิก")),
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                  onDeleteBid(id_bids, id_auctions);
                }, child: Text('ยืนยัน'))
              ],
            ),);
      }, child: Text('ยกเลิกเสนอราคา', style: TextStyle(
          color: Colors.red,
          fontSize: 13
      ),
      ));
    } else {
      return Text("หมดเวลายกเลิกเสนอราคาแล้ว", style: TextStyle(
          fontSize: 13,
          color: Colors.orange
      ),);
    }
  }

  void onDeleteBid(var id_bids, var id_auctions) async {
    // print("Delete");
    String api = ConfigAPI().getUserBidDeleteServerDelete(
        id_bids: id_bids, id_auctions: id_auctions);
    Uri uri = Uri.parse(api);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text('แจ้งเตือน'),
            content: Text('ยกเลิกการเสนอราคาสำเร็จ'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text("ตกลง"))
            ],
          ),);
    } else {
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Text("ยกเลิกการเสนอราคาล้มเหลว: ${response.statusCode}"),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text('ตกลง'))
            ],
          ),);
    }
  }
}
