import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';
import 'package:prototype_your_auction_services/screen/BidLists.dart';
import 'package:prototype_your_auction_services/screen/Login.dart';
import 'package:prototype_your_auction_services/screen/MyAuctions.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

class DetailAuction extends StatefulWidget {
  State<DetailAuction> createState() {
    return DetailAuctionState();
  }
}

class DetailAuctionState extends State<DetailAuction> {
  var _bid = TextEditingController();
  var max_price;
  Map<String, dynamic> detailAuctionData = {};
  List<dynamic> _imageData = [];
  int indexSelectImage = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียด: ${ShareProductData.productData['name_product']}",
        ),
      ),
      body: StreamBuilder(
        stream: fetchDataDetailAuctions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("เกิดข้อผิดพลาด"),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  showOneImage(),
                  SizedBox(height: 8),
                  showAndSelectImage(),
                  SizedBox(height: 8),
                  selectShowImage(),
                  SizedBox(height: 8),
                  displayDataAuction(context, snapshot.data),
                  SizedBox(height: 500),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget showOneImage() {
    return Container(
      width: 500,
      height: 300,
      child:
      (_imageData.length == 0)
          ? Center(child: Text("ไม่พบรูปภาพ"))
          : Image.network(
        '${ConfigAPI().getImageAuctionApiServerGet(
            image_auction_path: _imageData![indexSelectImage])}',
      ),
    );
  }


  Widget showAndSelectImage() {
    return Container(
      width: 100,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageData.length,
        itemBuilder:
            (context, index) => Card(
              child: InkWell(
                onTap:
                    () =>
                {
                  setState(() {
                    indexSelectImage = index;
                  }),
                },
                child: Image.network(
                  '${ConfigAPI().getImageAuctionApiServerGet(
                      image_auction_path: _imageData[index])}',
                ),
              ),
            ),
      ),
    );
  }

  Widget selectShowImage() {
    return Container(
      // color: Colors.lightBlueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed:
                () => {
                  if (indexSelectImage > 0)
                    {
                      setState(() {
                        indexSelectImage -= 1;
                      }),
                    },
                },
            icon: Icon(Icons.arrow_back_sharp),
          ),
          // Text("Start"),
          Column(
            children: [
              // Text("ทดสอบต่ำแหน่ง: " + indexSelectImage.toString()),
              Text(
                _imageData.length == 0
                    ? "ไม่มีรูปภาพ"
                    : "รูปภาพที่: ${indexSelectImage + 1} / 10",
              ),
              // Text("จำนวนรูปภาพทั้งหมด: ${_imageData.length} / 10"),
            ],
          ),
          // Text("End"),
          IconButton(
            onPressed:
                () => {
                  if (indexSelectImage < _imageData.length - 1)
                    {
                      setState(() {
                        indexSelectImage += 1;
                      }),
                    },
                },
            icon: Icon(Icons.arrow_forward_sharp),
          ),
        ],
      ),
    );
  }

  Widget displayDataAuction(BuildContext ctx, dynamic data) {
    max_price = data['max_price'];
    return Padding(
      padding: EdgeInsets.all(19),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("เหลือเวลา: ", style: headText()),
              // showDateTimeCountdown(),
              countdown(),
              Text(" วินาที", style: redText()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ราคาสูงสุด: ", style: headText()),
              Text("${data!['max_price']}", style: redText()),
            ],
          ),
          textButtonGoToBidLists(ctx, data!['bids_count']),
          onBit(data['id_users']),
          SizedBox(height: 7),
          Row(
            children: [
              Text("ผู้เปิดประมูล: ", style: headText()),
              Text("${data!['first_name_users']} ${data!['last_name_users']}",
                  style: defaultText()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("ชื่อสินค้า: ", style: headText()),
              Text("${data!['name_product']}", style: defaultText()),
            ],
          ),
          Row(children: [Text("ข้อมูลเพิ่มเติม: ", style: headText())]),
          Text(
            "${data!['detail_product']}",
            textAlign: TextAlign.justify,
            overflow: TextOverflow.clip,
            style: defaultText(),
          ),
        ],
      ),
    );
  }

  // Widget displayDataAuction() {
  //   return Text("data");
  // }

  Widget displayImages(dynamic data) {
    double left = 0.0;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data,
      // itemCount: data!['images'].length,
      itemBuilder: (context, index) {
        return Text("data");
        // Map<String, dynamic> data = snapshot.data
        // return Padding(
        //   padding: EdgeInsets.all(8),
        //   child: Container(
        //     padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        //     child: Image.network(
        //       'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image/'
        //       '${data!['images'][index]}',
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // );
      },
    );
  }

  Stream<Map<String, dynamic>> fetchDataDetailAuctions() async* {
    // Future.delayed(Duration(seconds: 1));
    // print('Start.detailAuctions');
    // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/product-detail/${ShareProductData
    //     .productData['id_auctions']}';
    String url = ConfigAPI().getProductDetailApiServerGet(
        id_auctions: ShareProductData.productData['id_auctions']);
    // String url = 'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/product-detail/${ShareProductData
    //     .productData['id_auctions']}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    Map<String, dynamic> data = resData['data'];
    // print("aaaaaaaaaaaaaaaaaaaa");
    // print(data['images'].toString());
    yield data;
    setState(() {
      detailAuctionData = data;
      _imageData = data["images"];
    });
    // print('End.detialAuctions');
  }

  Widget onBit(var id_users_owner) {
    // return checkProductOwner();
    // print(id_users_owner.toString());
    // return Text("${isProductOwner(id_users_owner)}");
    if (isProductOwner(id_users_owner)) {
      // return Text("เจ้าของสินค้า ไม่สามารถเสนอราคาได้");
      return ElevatedButton(onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyAuctions(),));
      }, child: Text("หน้าจัดการร้านค้า"));
    }
    return Column(
      children: [
        SizedBox(
          // height: 200,
          width: 200,
          child: TextField(
            style: TextStyle(),
            controller: _bid,
            decoration: InputDecoration(hintText: "เสนอราคา"),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 110,
          height: 30,
          child: ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {
              confirmButton();
            },
            child: Text("เสนอราคา"),
          ),
        ),
        // Row(crossAxisAlignment: CrossAxisAlignment.center, children: []),
      ],
    );
  }

  void submitOnBidding() async {
    // print("Start.");
    try {
      int bid_price = int.parse(_bid.text);
      // print("Check num bid: ${bid_price.runtimeType == int}");
      if (ShareData.userData['id_users'] != null) {
        if (bid_price > max_price) {
          Map<String, dynamic> data = {
            'id_users': ShareData.userData['id_users'],
            'id_auctions': ShareProductData.productData['id_auctions'],
            'bid_price': bid_price,
          };

          // String url = 'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/bidding';
          String url = ConfigAPI().getBidding();
          final uri = Uri.parse(url);
          final responce = await http.post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(data),
          );

          final reActions = jsonDecode(responce.body);

          if (responce.statusCode == 201) {
            await showDialog(
              context: context,
              builder:
                  (context) =>
                  AlertDialog(
                    title: Text("เสนอราคาสำเร็จ"),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text("ตกลง"),
                      ),
                    ],
                  ),
            );
            // print("Successfully: " + responce.statusCode.toString());

            _bid.text = '';
            setState(() {});
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => DetailAuction()),
            // );
          } else {
            _alertDialog(title: "เกิดข้อผิดพลาด");
            print("Error: " + responce.statusCode.toString());
          }
        } else {
          showDialog(context: context, builder: (context) =>
              AlertDialog(
                title: Text("ล้มเหลว"),
                content: Text("จะต้องเสนอราคาที่สูงกว่าราคาสูงสุดเท่านั้น"),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, child: Text("ตกลง"))
                ],
              ),);
        }
      } else {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("กรุณาเข้าสู่ระบบ"),
                content: Text("คุณต้องการเข้าสู่ระบบหรือไม่"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel', style: TextStyle(fontSize: 18)),
                  ),
                  TextButton(
                    onPressed: () {
                      goToLogin();
                    },
                    child: Text('OK', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
        );

        print('กรุณาเข้าสู่ระบบ');
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
    print("End.");
  }

  TextStyle headText() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }

  TextStyle redText() {
    return TextStyle(
      // color: Colors.red,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle defaultText() {
    return TextStyle(fontSize: 16);
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

  // bool compareCurrentDateTimeAndEndDateTime(DateTime date_time_curent, DateTime end_date_time) {
  //   if ()
  //   return true;
  // }

  Widget countdown() {
    // final start_date_time_data = detailAuctionData['start_date_time'];
    final end_date_time_data = detailAuctionData['end_date_time'];
    // print("หน้า Detail, Methode: contdown: " + end_date_time_data.toString());
    // var min;
    var end_date_time = DateTime.parse(end_date_time_data);

    var date_tiem_difference = end_date_time.difference(DateTime.now());
    // print("ความต่างของเวลา: " + date_tiem_difference.toString());
    var countdown = TimerCountdown(
      endTime: DateTime.now().add(
        Duration(seconds: date_tiem_difference.inSeconds),
      ),
      onTick: (remainingTime) {
        // print("Test: " + remainingTime.inMinutes.toString());
        // _countDownDateTime = remainingTime.inDays;
      },
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
      onEnd: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuctionHome(),));
        showDialog(
          context: context,
          builder:
              (context) =>
              AlertDialog(
                title: Text('หมดเวลา'),
                content: Text("สามารถตรวจสอบผลการประมูล"),
                actions: [
                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).pop()
                    },
                    child: Text('ตกลง'),
                  ),
                ],
              ),
        );
      },
    );
    // print("ต้องรับเป็นตัวแปร Duration เท่านั้น: " + _countDownDateTime.toString());

    return countdown;
  }

  void _alertDialog({String? title, String? message}) async {
    await showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(title: Text(title!), content: Text(message!)),
    );
  }

  void confirmButton() {
    try {
      int bid_price = int.parse(_bid.text);
      showDialog(
        context: context,
        builder:
            (context) =>
            AlertDialog(
              title: Text("ยืนยันการเสนอราคา"),
              content: Text("จำนวนเงิน: " + _bid.text),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailAuction(),));
                  },
                  child: Text('Cancel', style: TextStyle(fontSize: 18)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      submitOnBidding();
                    });
                  },
                  child: Text('OK', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
      );
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder:
            (context) =>
            AlertDialog(
              title: Text("แจ้งเตือน"),
              content: Text(
                "กรุณาตรวจสอบความถูกต้องอีกครั้ง.",
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
    }
  }

  void goToLogin() {
    final route = MaterialPageRoute(builder: (context) => Login());

    Navigator.pushReplacement(context, route);
  }

  bool isProductOwner(var id_users_owner) {
    var id_users = ShareData.userData['id_users'].toString();
    // return id_users;
    if (ShareData.userData['id_users'] == id_users_owner) {
      return true;
    } else {
      return false;
    }
  }

}


// void test() {
//   TimerCountdown(endTime: DateTime(2025, 5, 7, 21, 02, DateTime.now().second), onEnd: () {
//     print("ZZZZZZZZZZZZZZZZZ");
//   },);
// }
// }
