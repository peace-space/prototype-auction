import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/DetailAuction.dart';
import 'package:prototype_your_auction_services/share/CheckLogin.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

class AuctionHome extends StatefulWidget {
  State<AuctionHome> createState() {
    return AuctionHomeState();
  }
}

class AuctionHomeState extends State<AuctionHome> {
  String messageButton = "รายการ";
  bool _changeDisplay = false;
  String loginStatus = "";
  Map<String, dynamic> images_data = {};
  var _timeout;
  late BuildContext ctx;
  var end_date_time_check;

  // Map<String, dynamic> dateTimeCoundown = {};

  @override
  void initState() {
    // TODO: implement initState
    print("\n\n\n\n\n\n\n\n\n\nTest");
    super.initState();
    CheckLogin().onCheckLogin();
    setState(() {
      loginStatus = logedIn();
    });
  }

  Widget build(BuildContext context) {
    double left = 8.0;
    double top = 0.0;
    double right = 8.0;
    double bottom = 0.0;
    setState(() {
      this.ctx = context;
      loginStatus = logedIn();
    });
    return Scaffold(
      appBar: AppBar(title: Text("Home: ${loginStatus}")),
      body: Column(
        children: [
          Container(
            //color: Colors.lightBlueAccent,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(left, top, right, bottom),
            alignment: Alignment.topRight,
            height: 23,
            child: changeDisplayButton(context),
          ),
          SizedBox(height: 3),
          Expanded(child: displayer(context)),
        ],
      ),
      drawer: createDrawer(context),
    );
  }

  String logedIn() {
    if (ShareData.logedIn) {
      return "เข้าสู่ระบบแล้ว";
    } else {
      return "ยังไม่เข้าสู่ระบบ";
    }
  }

  Widget auctionGrid(BuildContext ctx) {
    double left = 8.0;
    double top = 0.0;
    double right = 8.0;
    double bottom = 8.0;

    return StreamBuilder(
      stream: fetchAuctionData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error."));
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          try {
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(left, top, right, bottom),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //จำนวนคอลลัมน์
                crossAxisSpacing: 10, //ระยะห่างระหว่างคอลลัมน์
                mainAxisSpacing: 10, //ระยะห่างระหว่างแถว
                //mainAxisExtent: 300, //ขนาดของรูปภาพ
                childAspectRatio: 0.52, //อัตตราส่วนของช่อง (กว้าง / สูง)
              ),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data?[index];

                if ((data['auction_status'] == 1)) {
                  return InkWell(
                    onTap: () => goToDetailAuction(ctx, snapshot.data?[index]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              // child: Image.network(
                              //   'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/get-image' +
                              //       data['image_path_1'],
                              //   cacheHeight: 600,
                              //   cacheWidth: 500,
                              // ),
                              child: Image.network(
                                'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image' +
                                    data['image_path_1'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['name_product']),
                                SizedBox(height: 5),
                                Text("ราคาสูงสุด ฿${data['max_price']
                                    .toString()}"),
                                SizedBox(height: 5),
                                showDateTimeCountdown(data),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          } on Exception catch (e) {
            AlertDialog(
                title: Text("แจ้งเตือน"),
                content: Text('หมดเวลาหรือไม่มีการประมูลนี้แล้ว'),
                actions: [
                  TextButton(onPressed: () =>
                  {
                    Navigator.of(context).pop()
                  }, child: Text("ตกลง"))
                ]
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget auctionList(BuildContext ctx) {
    return StreamBuilder(
      stream: fetchAuctionData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error."));
        }

        if (snapshot.connectionState == ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          try {
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
                      child: Card(
                        child: ListTile(
                          onTap: () => goToDetailAuction(ctx, data),
                          leading: ClipRRect(
                            // borderRadius: BorderRadius.vertical(),
                            child: Image.network(
                              'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image' +
                                  data['image_path_1'],
                              cacheHeight: 600,
                              cacheWidth: 500,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['name_product']),
                              Text("ราคาสูงสุด ฿${data['max_price']
                                  .toString()}"),
                            ],
                          ),
                          subtitle: showDateTimeCountdown(data),
                        ),
                      )
                  );
              },
            );
          } on Exception catch (e) {
            AlertDialog(
                title: Text("แจ้งเตือน"),
                content: Text('หมดเวลาหรือไม่มีการประมูลนี้แล้ว'),
                actions: [
                  TextButton(onPressed: () =>
                  {
                    Navigator.of(context).pop()
                  }, child: Text("ตกลง"))
                ]
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Stream<List<dynamic>> fetchAuctionData() async* {
    try {
      // await Future.delayed(Duration(seconds: 5));
      print("Start");
      String url =
          'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/auction';
      // String url = 'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/auction';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final resData = jsonDecode(response.body);
      List<dynamic> auctions_data = resData['data'];
      // List<dynamic>? data = checkEndDateTime(auctions_data);

      // print(data.toString());
      // print(data[9]['id_auctions'].toString());
      yield auctions_data;
      // yield auctions_data;
      setState(() {});
    } on Exception catch (e) {
      print(e);
    }
  }

  Widget displayer(BuildContext ctx) {
    if (_changeDisplay) {
      return auctionList(ctx);
    } else {
      return auctionGrid(ctx);
    }
  }

  void changeDisplayStatus(BuildContext ctx) {
    if (_changeDisplay) {
      setState(() {
        messageButton = "รายการ";
        _changeDisplay = false;
      });
    } else {
      setState(() {
        messageButton = "รูปภาพ";
        _changeDisplay = true;
      });
    }
  }

  Widget changeDisplayButton(BuildContext ctx) {
    return ElevatedButton(
      onPressed: () => changeDisplayStatus(ctx),
      child: Text(messageButton),
    );
  }

  void goToDetailAuction(BuildContext ctx, Map<String, dynamic> data) {
    try {
      ShareProductData.productData = data;
      final route = MaterialPageRoute(builder: (ctx) => DetailAuction());

      Navigator.push(ctx, route);
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("แจ้งเตือน"),
              content: Text('หมดเวลาหรือไม่มีการประมูลนี้แล้ว'),
              actions: [
                TextButton(onPressed: () =>
                {
                  Navigator.of(context).pop()
                }, child: Text("ตกลง"))
              ],
            ),
      );
    }
  }

  // Widget countdown(Map<String, dynamic> data) {
  //   // print(end_date_time_data.toString());
  //   // print(data.toString());
  //   // Future.delayed(Duration(seconds: 1));
  //   var end_date_time = DateTime.parse(data['end_date_time']);
  //   var date_time_difference = end_date_time.difference(DateTime.now());
  //
  //   TimerCountdown countdown_date_time = TimerCountdown(
  //     endTime: DateTime.now().add(
  //       Duration(seconds: date_time_difference.inSeconds),
  //     ),
  //     onTick: (end_time) {
  //       // print(end_time.inSeconds.toString());
  //       end_date_time_check = end_time.inSeconds;
  //       if (end_time.inSeconds == 0) {
  //         print(
  //             "+++++++++++++++++++++++++++++" + end_time.inSeconds.toString());
  //       }
  //     },
  //     onEnd: () {
  //       // saveTheWinnerAuctions(data);
  //     },
  //     format: CountDownTimerFormat.daysHoursMinutesSeconds,
  //     enableDescriptions: false,
  //     spacerWidth: 0,
  //     timeTextStyle: TextStyle(fontSize: 18, color: Colors.red, height: 0),
  //     daysDescription: "day",
  //     hoursDescription: "hour",
  //     minutesDescription: "min",
  //     secondsDescription: "sec",
  //     descriptionTextStyle: TextStyle(height: 0),
  //     colonsTextStyle: TextStyle(fontSize: 18, color: Colors.red),
  //   );
  //
  //   if (end_date_time_check == 0) {
  //     saveTheWinnerAuctions(data);
  //   }
  //
  //   return countdown_date_time;
  // }

  Widget showDateTimeCountdown(Map<String, dynamic> data) {
    DateTime dateTime = DateTime.parse(data['end_date_time']);
    return CountdownTimer(
      endTime: dateTime.millisecondsSinceEpoch,
      widgetBuilder: (context, time) {
        if (time == null) {
          return Text('หมดเวลา', style: TextStyle(
              color: Colors.red
          ),);
        }
        String day = (time.days == null || time.days == 00) ? "00" : time.days
            .toString();
        String hour = (time.hours == null || time.hours == 00) ? "00" : time
            .hours.toString();
        String min = (time.min == null || time.hours == 00) ? "00" : time.min
            .toString();
        String sec = (time.sec == null) ? "00" : time.sec.toString();

        return Text(
          "เวลา: ${day} : ${hour} : ${min} : ${sec}", style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red
        ),
        );
      },
      onEnd: () {
        saveTheWinnerAuctions(data);
      },
    );
  }


  // List<Map<String, dynamic>> checkEndDateTime(List<dynamic> data) {
  //   // void checkEndDateTime(List<dynamic> data) async {
  //   // print('Start.');
  //   // var check_timeout = DateTime.parse(data['end_date_time']);
  //   // Duration different_date_time = check_timeout.difference(DateTime.now());
  //   // print(different_date_time.inMinutes.toString());
  //
  //   List<Map<String, dynamic>> newData = [];
  //
  //   for (int index = 0; index < data.length; index++) {
  //     var check_timeout = DateTime.parse(data[index]['end_date_time']);
  //     Duration different_date_time = check_timeout.difference(DateTime.now());
  //     // print(different_date_time.inMinutes.toString());
  //
  //     if (different_date_time >= Duration.zero) {
  //       newData.add(data[index]);
  //     }
  //   }
  //
  //   return newData;
  //
  //   print('End.');
  // }

  void saveTheWinnerAuctions(Map<String, dynamic> data) async {
    // Map<String, dynamic> data = {'id_auctions': 1};
    print(data.toString());

    Map<String, dynamic> winner_data = {
      'id_auctions': data['id_auctions']
    };
    String url =
        'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/save-the-winners';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(winner_data),
    );
    if (response.statusCode == 201) {
      final reActionData = jsonDecode(response.body);
      print(reActionData['message']);
    } else {
      print(response.statusCode.toString());
    }
  }
}
