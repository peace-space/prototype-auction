// import 'dart:nativewrappers/_internal/vm/lib/convert_patch.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/channel/MyAuctionChannel.dart';
import 'package:prototype_your_auction_services/model/MyAuctionModel.dart';
import 'package:prototype_your_auction_services/screen/MyAuctionDetail.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/widget_shared/show_count_down_timer.dart';

import '../controller/AuctionController.dart';
import '../controller/ProductTypesController.dart';

class MyAuctions extends StatefulWidget {
  State<MyAuctions> createState() {
    return MyAuctionsState();
  }
}

class MyAuctionsState extends State<MyAuctions> {
  var _productTypeValues;
  bool _search_mode = false;
  var _key_word = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: (!_search_mode)? Text("รายการประมูลของฉัน"): Row(
            children: [
              Expanded(child: TextField(
                controller: _key_word,
                decoration: InputDecoration(
                    hintText: "ค้นหา"
                ),
              )),
              IconButton(onPressed: () {
                // AuctionController().fetchAuctionSelectTypes(id_products: selectProductType(_productTypeValues), key_word: _key_word.text);

                setState(() {});
              }, icon: Icon(Icons.search))
            ],
          ),
        actions: [
          (!_search_mode)?
          IconButton(onPressed: () {
            _search_mode = !_search_mode;
            setState(() {});
          }, icon: Icon(Icons.search)) :
          IconButton(onPressed: () {
            _search_mode = !_search_mode;
            _key_word.text = '';
            setState(() {});
          }, icon: Icon(Icons.search_off))
        ],
      ),
      body: displayMyAuctions(context),
    );
  }

  Widget displayMyAuctions(BuildContext ctx) {
    double left = 8.0;
    double top = 0.0;
    double right = 8.0;
    double bottom = 0.0;
    return Column(
      children: [
        Container(
            // color: Colors.lightBlueAccent,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(left, top, right, bottom),
            alignment: Alignment.topRight,
            // height: 23,
            height: 50,
            child: FutureBuilder(
              future: ProductTypesController().fetchProductTypes(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("เกิดข้อผิดพลาด"));
                }
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      inputProductTypes(snapshot.data),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },),
          ),
        Expanded(
          child: StreamBuilder(
              // stream: fetchUserProduct(),
              stream: MyAuctionChannel().connect(id_users: ShareData.userData['id_users'], id_product_types: ProductTypesController().selectProductType(_productTypeValues), key_word: _key_word.text).stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error."),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  MyAuctionModel().setConvertToData(snapshot.data);
                  dynamic data = MyAuctionModel().getConvertToData();
                  // return Text("Test: ${data}");

                  if (data == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (data != null) {
                    return ListView.builder(
                        itemCount: data!.length,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> my_auction_data = data![index];
                    
                          double left = 0.0;
                          double top = 0.0;
                          double right = 8.0;
                          double bottom = 8.0;
                          return Padding(
                            padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                            child: ListTile(
                              onTap: () => goToUserProductManage(ctx, my_auction_data),
                              leading: ClipRRect(
                                // borderRadius: BorderRadius.vertical(),
                                child: Image.network(
                                  '${ConfigAPI().getImageAuctionApiServerGet(
                                      image_auction_path: my_auction_data['image_path_1'])}',
                                  cacheHeight: 600,
                                  cacheWidth: 500,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${my_auction_data['name_product']}"),
                                  Row(children: [
                                    Text("สถานะการประมูล: "),
                                    auctionStatus(my_auction_data['auction_status']),
                                  ],),
                                  Text('ประเภทสินค้า: ${my_auction_data['product_type_text']}'),
                                  Text('ประเภทการประมูล: ${my_auction_data['auction_types']}'),
                                  Row(
                                    children: [
                                      Text("เหลือเวลาอีก: "),
                                      countDownList(context, my_auction_data['end_date_time']),
                                    ],
                                  ),
                                  Text("หน่วยเวลา (วัน : ชั่วโมง : นาที : วินาที)", style: TextStyle(fontSize: 13),),
                                ],
                              ),
                              subtitle: Divider(),
                            ),
                          );
                        }
                    );
                  }
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
          ),
        ),
      ],
    );
  }

  Stream<dynamic> fetchUserProduct() async* {
    // print("Start MyAuction");
    // // print(ShareData.userData['id_users']);
    // String url = ConfigAPI().getMyAuctionsServerGet(
    //     id_users: ShareData.userData['id_users'].toString());
    // final uri = Uri.parse(url);
    // final response = await http.get(uri);
    // Map<String, dynamic> resData = jsonDecode(response.body);
    //
    // List<dynamic> data = resData['data'];
    //
    // // if (data.length == 0) {
    // //   yield null;
    // // }
    //
    // // ShareProductData.productData = data;
    //
    // print(data.toString());
    //
    // yield data;
    // print("End. My Auction");
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

  Widget auctionStatus(int auction_status) {
    if (auction_status == 1) {
      return Text("กำลังประมูล", style: TextStyle(
        color: Colors.orange,
      ),);
      // return "กำลังประมูล";
    } else {
      return Text("ปิดประมูลแล้ว");
      // return "ปิดประมูลแล้ว";
    }
  }

  void goToUserProductManage(BuildContext ctx, Map<String, dynamic> data) {
    ShareProductData.productData = data;
    // print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL: " + data.toString());
    final route = MaterialPageRoute(builder: (ctx) => MyAuctionDetail(),);

    Navigator.push(ctx, route);
  }

  Widget inputProductTypes(dynamic product_types_data) {
    List<String>? product_types = [];

    if (product_types_data != null) {
      for (int i = 0; i <= product_types_data.length - 1; i++) {
        print('${i + 1} ${product_types_data[i]['product_type_text']}');
        product_types.add(product_types_data[i]['product_type_text'].toString());
      }
      // product_types.reversed;
      product_types.add('ทั้งหมด');
      // print("::: ${product_types.length}");

      return DropdownButton(
        hint: Text("ประเภทสินค้า"),
        isExpanded: false,
        // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        value: _productTypeValues,
        items:
        product_types.map((data) {
          return DropdownMenuItem(
            value: data,
            child: Center(child: Text(data)),
          );
        }).toList(),
        onChanged:
            (value) =>
        {
          setState(() {
            _productTypeValues = value.toString();
          }),
        },
      );
    } else {
      return Text("${product_types_data}");
    }

  }
}
