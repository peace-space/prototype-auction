// import 'dart:nativewrappers/_internal/vm/lib/convert_patch.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/MyAuctionDetail.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class MyAuctions extends StatefulWidget {
  State<MyAuctions> createState() {
    return MyAuctionsState();
  }
}

class MyAuctionsState extends State<MyAuctions> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการประมูลของฉัน")),
      body: displayMyAuctions(context),
    );
  }

  Widget displayMyAuctions(BuildContext ctx) {
    return StreamBuilder(
        stream: fetchUserProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error."),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data?[index];

                  double left = 0.0;
                  double top = 0.0;
                  double right = 8.0;
                  double bottom = 8.0;
                  return Padding(
                    padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                    child: ListTile(
                      onTap: () => goToUserProductManage(ctx, data),
                      leading: ClipRRect(
                        // borderRadius: BorderRadius.vertical(),
                        child: Image.network(
                          '${ConfigAPI().getImageAuctionApiServerGet(
                              image_auction_path: data['image_path_1'])}',
                          cacheHeight: 600,
                          cacheWidth: 500,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data['name_product']}"),
                          Text("สถานะการประมูล: ${auctionStatus(
                              data['auction_status'])}"),
                        ],
                      ),
                      subtitle: Text(""),
                    ),
                  );
                }
            );
          }

          if (snapshot.data == null) {
            return Center(
              child: Text("คุณไม่มีสินค้าที่เปิดประมูล"),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Stream<dynamic> fetchUserProduct() async* {
    print("Start MyAuction");
    // print(ShareData.userData['id_users']);
    String url = ConfigAPI().getMyAuctionsServerGet(
        id_users: ShareData.userData['id_users'].toString());
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    Map<String, dynamic> resData = jsonDecode(response.body);

    List<dynamic> data = resData['data'];

    // if (data.length == 0) {
    //   yield null;
    // }

    // ShareProductData.productData = data;

    print(data.toString());

    yield data;
    print("End. My Auction");
  }

  // Widget countdown(String end_date_time_data) {
  //   // print(end_date_time_data.toString());
  //
  //   var end_date_time = DateTime.parse(end_date_time_data);
  //
  //   var date_tiem_difference = end_date_time.difference(DateTime.now());
  //
  //   return TimerCountdown(
  //     endTime: DateTime.now().add(
  //         Duration(seconds: date_tiem_difference.inSeconds)),
  //     format: CountDownTimerFormat.daysHoursMinutesSeconds,
  //     enableDescriptions: false,
  //     spacerWidth: 0,
  //     timeTextStyle: TextStyle(
  //       fontSize: 18,
  //       color: Colors.red,
  //       height: 0,
  //     ),
  //     daysDescription: "day",
  //     hoursDescription: "hour",
  //     minutesDescription: "min",
  //     secondsDescription: "sec",
  //     descriptionTextStyle: TextStyle(
  //       height: 0,
  //     ),
  //     colonsTextStyle: TextStyle(
  //         fontSize: 18,
  //         color: Colors.red
  //     ),
  //   );
  // }


  // Widget countdown(String end_date_time_data) {
  //   DateTime dateTime = DateTime.parse(end_date_time_data);
  //   return CountdownTimer(
  //     endTime: dateTime.millisecondsSinceEpoch,
  //     widgetBuilder: (context, time) {
  //       if (time == null) {
  //         return Text('หมดเวลา', style: TextStyle(
  //             color: Colors.red
  //         ),);
  //       }
  //       String hour = time.hours.toString();
  //       String min = time.min.toString();
  //       String sec = time.sec.toString();
  //       return Text("${hour} : ${min} : ${sec}");
  //     },
  //   );
  // }

  String auctionStatus(int auction_status) {
    if (auction_status == 1) {
      return "กำลังประมูล";
    } else {
      return "ปิดประมูลแล้ว";
    }
  }

  void goToUserProductManage(BuildContext ctx, Map<String, dynamic> data) {
    ShareProductData.productData = data;
    // print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL: " + data.toString());
    final route = MaterialPageRoute(builder: (ctx) => MyAuctionDetail(),);

    Navigator.push(ctx, route);
  }
}
