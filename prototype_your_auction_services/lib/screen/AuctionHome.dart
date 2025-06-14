import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/DetailAuction.dart';
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

  // Map<String, dynamic> dateTimeCoundown = {};

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      loginStatus = logedIn();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    double left = 8.0;
    double top = 0.0;
    double right = 8.0;
    double bottom = 0.0;
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
                          //   'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/public' +
                          //       '${data['image_path_1']}',
                          child: Image.network(
                            'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image/' +
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
                            Text("ราคาสูงสุด ฿${data['max_price'].toString()}"),
                            SizedBox(height: 5),

                            Row(
                              children: [
                                Text(
                                  "เวลา: ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                                countdown(data),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
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
                  onTap: () => goToDetailAuction(ctx, data),
                  leading: ClipRRect(
                    // borderRadius: BorderRadius.vertical(),
                    child: Image.network(
                      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image/' +
                          data['image_path_1'],
                      cacheHeight: 600,
                      cacheWidth: 500,
                    ),
                  ),
                  title: Text(data['name_product']),
                  subtitle: Text("ราคาสูงสุด ฿${data['max_price'].toString()}"),
                  trailing: Column(
                    children: [Text('เวลา'), countdown(data)],
                  ),
                ),
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Stream<List<dynamic>> fetchAuctionData() async* {
    try {
      await Future.delayed(Duration(seconds: 1));
      // print("Start");
      String url =
          'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/auction';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final resData = jsonDecode(response.body);
      List<dynamic> auctions_data = resData['data'];
      List<dynamic>? data = checkEndDateTime(auctions_data);
      // print(data.toString());
      yield data;
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
    ShareProductData.productData = data;
    final route = MaterialPageRoute(builder: (ctx) => DetailAuction());

    Navigator.push(ctx, route);
  }

  Widget countdown(Map<String, dynamic> data) {
    // print(end_date_time_data.toString());
    // print(data.toString());
    var end_date_time = DateTime.parse(data['end_date_time']);

    var date_tiem_difference = end_date_time.difference(DateTime.now());

    return TimerCountdown(
      endTime: DateTime.now().add(
        Duration(seconds: date_tiem_difference.inSeconds),
      ),
      onEnd: () {
        winTheAuction(data);
      },
      format: CountDownTimerFormat.daysHoursMinutesSeconds,
      enableDescriptions: false,
      spacerWidth: 0,
      timeTextStyle: TextStyle(fontSize: 18, color: Colors.red, height: 0),
      daysDescription: "day",
      hoursDescription: "hour",
      minutesDescription: "min",
      secondsDescription: "sec",
      descriptionTextStyle: TextStyle(height: 0),
      colonsTextStyle: TextStyle(fontSize: 18, color: Colors.red),
    );
  }

  List<Map<String, dynamic>> checkEndDateTime(List<dynamic> data) {
    // void checkEndDateTime(List<dynamic> data) async {
    // print('Start.');
    // var check_timeout = DateTime.parse(data['end_date_time']);
    // Duration different_date_time = check_timeout.difference(DateTime.now());
    // print(different_date_time.inMinutes.toString());

    List<Map<String, dynamic>> newData = [];

    for (int index = 0; index < data.length; index++) {
      var check_timeout = DateTime.parse(data[index]['end_date_time']);
      Duration different_date_time = check_timeout.difference(DateTime.now());
      // print(different_date_time.inMinutes.toString());

      if (different_date_time >= Duration.zero) {
        newData.add(data[index]);
      }
    }

    return newData;

    print('End.');
  }

  void winTheAuction(Map<String, dynamic> data) async {
    print("Win The Auction");
    Future.delayed(Duration(seconds: 1000));
    int count = 0;
    count += 1;
    showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(
            title: Text("data: " + count.toString()),
            content: Text(
              "ยินดีด้วย คุณเป็นผู้ชนะประมูล",
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('OK', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
    );
    saveTheWinnerAuctions();

    String url = '';
    final uri = Uri.parse(url);
    // final
  }

  void saveTheWinnerAuctions() async {
    Map<String, dynamic> data = {
      'id_auctions': 1,
    };
    String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/save-the-winners';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      final reActionData = jsonDecode(response.body);
      print(reActionData['message']);
    } else {
      print(response.statusCode.toString());
    }
  }

}
