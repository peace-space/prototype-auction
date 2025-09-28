import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/channel/AuctionHomeChannel.dart';
import 'package:prototype_your_auction_services/controller/AuctionController.dart';
import 'package:prototype_your_auction_services/controller/ProductTypesController.dart';
import 'package:prototype_your_auction_services/model/AuctionModel.dart';
import 'package:prototype_your_auction_services/screen/DetailAuction.dart';
import 'package:prototype_your_auction_services/share/CheckLogin.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';
import 'package:prototype_your_auction_services/share/widget_shared/show_count_down_timer.dart';

import '../model/ProductTypesModel.dart';

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
  var id_product_types;
  var _productTypeValues;
  // var select_types;
  bool has_data = true;
  bool _search_mode = false;
  var _key_word = TextEditingController();

  @override
  void initState() {
    CheckLogin().onCheckLogin();
    ProductTypesController().fetchProductTypes();
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
    setState(() {
      this.ctx = context;
      loginStatus = logedIn();
    });
    return Scaffold(
      appBar: AppBar(
          title: (!_search_mode)? Text("Home: ${logedIn()}"): Row(
            children: [
              Expanded(child: TextField(
                controller: _key_word,
                decoration: InputDecoration(
                    hintText: "ค้นหา"
                ),
              )),
              IconButton(onPressed: () {
                AuctionController().fetchAuctionSelectTypes(id_products: selectProductType(_productTypeValues), key_word: _key_word.text);
                // _search_mode = ! _search_mode;
                // _key_word.text = '';
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
      body: Column(
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
                  return Text("เกิดข้อผิดพลาด");
                }
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      inputProductTypes(snapshot.data),
                      changeDisplayButton(context),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },),
          ),
          SizedBox(height: 3),
          // Expanded(child: displayer(context)),
          Expanded(child: StreamBuilder(
            stream: AuctionHomeChannel.connect(id_products: selectProductType(_productTypeValues), key_word: _key_word.text).stream,
            builder: (context, snapshot) {
              // print("${snapshot.data}");
              if (snapshot.hasError) {
                return const Center(child: Text("Error."));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                      child: AlertDialog(
                        title: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text("กำลังโหลดข้อมูล")
                          ],
                        ),
                      )
                  );
              }

              if (!snapshot.hasData) {
                return Center(
                    child: Text("ไม่มีข้อมูล", style: TextStyle(fontSize: 18),)
                );
              }

              if (snapshot.hasData) {
                AuctionModel().setConvertToMapAuctionList(snapshot.data);
                dynamic data = AuctionModel().getConvertToMapAuctionList();
                if (data == null || data.length == 0) {
                  return Center(
                      child: AlertDialog(
                        title: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text("กำลังโหลดข้อมูล")
                          ],
                        ),
                      )
                  );
                }
                if (data['hasData'] == 0) {
                  return Center(
                    child: Text("ไม่มีข้อมูล"),
                  );
                } else {
                  List auction_list = data['data'];
                  return displayer(ctx, auction_list);
                }}
              return Center(
                  child: AlertDialog(
                    title: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("กำลังโหลดข้อมูล")
                      ],
                    ),
                  )
              );
            },)
          )
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

  // Widget auctionGrid(BuildContext ctx) {
  //   double left = 8.0;
  //   double top = 0.0;
  //   double right = 8.0;
  //   double bottom = 8.0;
  //
  //   return StreamBuilder(
  //     // stream: fetchAuctionData(),
  //     stream: AuctionHomeChannel.connect(id_products: selectProductType(_productTypeValues), key_word: _key_word.text).stream,
  //     builder: (context, snapshot) {
  //       // print("${snapshot.data}");
  //       if (snapshot.hasError) {
  //         return const Center(child: Text("Error."));
  //       }
  //
  //       if (snapshot.connectionState == ConnectionState.none) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //
  //       if (!snapshot.hasData) {
  //         return Center(
  //             child: Text("ไม่มีข้อมูล")
  //         );
  //       }
  //
  //       if (snapshot.hasData) {
  //         AuctionModel().setConvertToMapAuctionList(snapshot.data);
  //         // dynamic auction_list = AuctionModel().getAuctionSelectTypesData();
  //         dynamic data = AuctionModel().getConvertToMapAuctionList();
  //         // print("${data}");
  //         if (data == null || data.length == 0) {
  //           return Center(
  //               child: AlertDialog(
  //                 title: Column(
  //                   children: [
  //                     CircularProgressIndicator(),
  //                     Text("กำลังโหลดข้อมูล")
  //                   ],
  //                 ),
  //               )
  //           );
  //           return Center(
  //               child: CircularProgressIndicator()
  //           );
  //           return Center(
  //               child: Text("ไม่มีข้อมูล")
  //           );
  //         }
  //         if (data['hasData'] == 0) {
  //           return Center(
  //             child: Text("ไม่มีข้อมูล"),
  //           );
  //         } else {
  //           List auction_list = data['data'];
  //           try {
  //             return SafeArea(
  //                 child: GridView.builder(
  //                   padding: EdgeInsets.fromLTRB(left, top, right, bottom),
  //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                     crossAxisCount: 2, //จำนวนคอลลัมน์
  //                     crossAxisSpacing: 10, //ระยะห่างระหว่างคอลลัมน์
  //                     mainAxisSpacing: 10, //ระยะห่างระหว่างแถว
  //                     //mainAxisExtent: 300, //ขนาดของรูปภาพ
  //                     childAspectRatio: 0.52, //อัตตราส่วนของช่อง (กว้าง / สูง)
  //                   ),
  //                   // itemCount: snapshot.data!.length,
  //                   itemCount: auction_list!.length,
  //                   itemBuilder: (context, index) {
  //                     Map<String, dynamic> data = auction_list![index];
  //
  //                     if ((data['auction_status'] == 1)) {
  //                       return InkWell(
  //                         onTap: () => goToDetailAuction(ctx, data),
  //                         child: Card(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.stretch,
  //                             children: [
  //                               Expanded(
  //                                 child: ClipRRect(
  //                                   borderRadius: BorderRadius.vertical(
  //                                     top: Radius.circular(15),
  //                                   ),
  //                                   child: Image.network(
  //                                     '${ConfigAPI().getImageAuctionApiServerGet(
  //                                         image_auction_path: data['image_path_1'])}',
  //                                     fit: BoxFit.cover,
  //                                   ),
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 child: Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(data['name_product']),
  //                                     Text("data"),
  //                                     // Text("ประเภท: ${data['product_type_text']}"),
  //                                     SizedBox(height: 5),
  //                                     Text("ราคาสูงสุด ฿${data['max_price']
  //                                         .toString()}"),
  //                                     SizedBox(height: 5),
  //                                     // Text("เหลือเวลา:"),
  //                                     // countDownList(context, data['end_date_time']),
  //                                     // Text("day:hour:min:sec"),
  //                                     // showDateTimeCountdown(data),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     }
  //                   },
  //                 )
  //             );
  //           } on Exception catch (e) {
  //             AlertDialog(
  //                 title: Text("แจ้งเตือน"),
  //                 content: Text('หมดเวลาหรือไม่มีการประมูลนี้แล้ว'),
  //                 actions: [
  //                   TextButton(onPressed: () =>
  //                   {
  //                     Navigator.of(context).pop()
  //                   }, child: Text("ตกลง"))
  //                 ]
  //             );
  //           }
  //         }
  //       }
  //
  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }

  // Widget auctionList(BuildContext ctx) {
  //   return StreamBuilder(
  //     // stream: fetchAuctionData(),
  //     stream: AuctionHomeChannel.connect(id_products: selectProductType(_productTypeValues), key_word: _key_word.text).stream,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Center(child: Text("Error."));
  //       }
  //
  //       if (snapshot.connectionState == ConnectionState.none) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: Text("ไม่มีข้อมูล"),
  //         );
  //       }
  //
  //       if (snapshot.hasData) {
  //         AuctionModel().setConvertToMapAuctionList(snapshot.data);
  //         // dynamic auction_list = AuctionModel().getAuctionSelectTypesData();
  //         dynamic data = AuctionModel().getConvertToMapAuctionList();
  //         // print("${data}");
  //         if (data == null || data.length == 0) {
  //           return Center(
  //               child: AlertDialog(
  //                 title: Column(
  //                   children: [
  //                     CircularProgressIndicator(),
  //                     Text("กำลังโหลดข้อมูล")
  //                   ],
  //                 ),
  //               )
  //           );
  //         }
  //         if (data['hasData'] == 0) {
  //           return Center(
  //             child: Text("ไม่มีข้อมูล"),
  //           );
  //         } else {
  //           List auction_list = data['data'];
  //           try {
  //             if (auction_list != null) {
  //               return SafeArea(
  //                   child:  ListView.builder(
  //                     itemCount: auction_list?.length,
  //                     padding: EdgeInsets.all(8),
  //                     itemBuilder: (context, index) {
  //                       Map<String, dynamic> data = auction_list[index];
  //
  //                       double left = 0.0;
  //                       double top = 0.0;
  //                       double right = 0.0;
  //                       double bottom = 0.0;
  //                       return Padding(
  //                           padding: EdgeInsets.fromLTRB(left, top, right, bottom),
  //                           child: Card(
  //                             child: ListTile(
  //                               onTap: () => goToDetailAuction(ctx, data),
  //                               leading: ClipRRect(
  //                                 // borderRadius: BorderRadius.vertical(),
  //                                 child: Image.network(
  //                                   '${ConfigAPI().getImageAuctionApiServerGet(
  //                                       image_auction_path: data['image_path_1'])}',
  //                                   cacheHeight: 600,
  //                                   cacheWidth: 500,
  //                                 ),
  //                               ),
  //                               title: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(data['name_product']),
  //                                   Text("SSS"),
  //                                   // Text("ประเภท: ${data['product_type_text']}"),
  //                                   Text("ราคาสูงสุด ฿${data['max_price']
  //                                       .toString()}"),
  //                                   Text("เวลาเหลือ"),
  //                                   countDownList(context, data['end_date_time']),
  //                                   Text("day:hour:min:sec"),
  //                                 ],
  //                               ),
  //                               // subtitle: countDownList(context, data['end_date_time']),
  //                               // subtitle: showDateTimeCountdown(data),
  //                             ),
  //                           )
  //                       );
  //                     },
  //                   )
  //               );
  //             }
  //           } on Exception catch (e) {
  //             AlertDialog(
  //                 title: Text("แจ้งเตือน"),
  //                 content: Text('หมดเวลาหรือไม่มีการประมูลนี้แล้ว'),
  //                 actions: [
  //                   TextButton(onPressed: () =>
  //                   {
  //                     Navigator.of(context).pop()
  //                   }, child: Text("ตกลง"))
  //                 ]
  //             );
  //           }
  //         }
  //
  //       }
  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }

  Stream<List<dynamic>> fetchAuctionData() async* {
    try {
      String url = ConfigAPI().getAuctionApi();
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final resData = jsonDecode(response.body);
      List<dynamic> auctions_data = resData['data'];


      yield auctions_data;
      setState(() {});
    } on Exception catch (e) {
      print(e);
    }
  }

  // Widget displayer(BuildContext ctx) {
  //   if (_changeDisplay) {
  //     return auctionList(ctx);
  //   } else {
  //     return auctionGrid(ctx);
  //   }
  // }
  Widget displayer(BuildContext ctx, auction_list) {
    if (_changeDisplay) {
      return SafeArea(
          child:  ListView.builder(
            itemCount: auction_list?.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              Map<String, dynamic> data = auction_list[index];

              double left = 0.0;
              double top = 0.0;
              double right = 0.0;
              double bottom = 0.0;
              return Padding(
                  padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                  child: Card(
                    child: ListTile(
                      onTap: () => goToDetailAuction(ctx, data),
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
                          Text(data['name_product'], style: TextStyle(
                              fontSize: 13
                          ),),
                          Text("ประเภทสินค้า: ${data['product_type_text']}", style: TextStyle(
                              fontSize: 13
                          ),),
                          Text("ราคาสูงสุด ฿${data['max_price']
                              .toString()}", style: TextStyle(
                              fontSize: 13
                          ),),
                          Text("เวลาเหลือ", style: TextStyle(
                              fontSize: 13
                          ),),
                          countDownList(context, data['end_date_time']),
                          Text("หน่วยเวลา (วัน : ชั่วโมง : นาที : วินาที)", style: TextStyle(fontSize: 13),),
                          // Text("day:hour:min:sec"),
                        ],
                      ),
                      // subtitle: countDownList(context, data['end_date_time']),
                      // subtitle: showDateTimeCountdown(data),
                    ),
                  )
              );
            },
          )
      );
    } else {
      double left = 8.0;
      double top = 0.0;
      double right = 8.0;
      double bottom = 8.0;
      // return auctionGrid(ctx);
      return SafeArea(
          child: GridView.builder(
            padding: EdgeInsets.fromLTRB(left, top, right, bottom),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //จำนวนคอลลัมน์
              crossAxisSpacing: 10, //ระยะห่างระหว่างคอลลัมน์
              mainAxisSpacing: 10, //ระยะห่างระหว่างแถว
              //mainAxisExtent: 300, //ขนาดของรูปภาพ
              childAspectRatio: 0.52, //อัตตราส่วนของช่อง (กว้าง / สูง)
            ),
            // itemCount: snapshot.data!.length,
            itemCount: auction_list!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = auction_list![index];

              if ((data['auction_status'] == 1)) {
                return InkWell(
                  onTap: () => goToDetailAuction(ctx, data),
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
                            child: Image.network(
                              '${ConfigAPI().getImageAuctionApiServerGet(
                                  image_auction_path: data['image_path_1'])}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['name_product'], style: TextStyle(
                                  fontSize: 13
                              ),),
                              Text("ประเภทสินค้า: ${data['product_type_text']}", style: TextStyle(
                                  fontSize: 13
                              ),),
                              // SizedBox(height: 5),
                              Text("ราคาสูงสุด ฿${data['max_price']
                                  .toString()}", style: TextStyle(
                                  fontSize: 13
                              ),),
                              // SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("เหลือเวลา: ", style: TextStyle(
                                      fontSize: 13
                                  ),),
                                  countDownList(context, data['end_date_time']),
                                ],
                              ),

                              Text("(วัน:ชั่วโมง:นาที:วินาที)", style: TextStyle(fontSize: 13),),
                              // showDateTimeCountdown(data),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          )
      );
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

  // String auctionSelectProductTypes(String auction_types) {
  //   List check_index_auction_types = AuctionTypesModel().getAuctionTypes();
  //   for (int index = 0; index <= check_index_auction_types.length - 1; index++) {
  //     if (auction_types == check_index_auction_types[index]['auction_types']) {
  //       return "${index + 1}";
  //     }
  //   }
  //
  //   return "1";
  //
  //   //   if (auction_types == '') {
  //   //     return "1";
  //   //   } else if (_dataAuctionTypeValue == 'ประมูลปกติ') {
  //   //     return "1";
  //   //   } else if (_dataAuctionTypeValue == 'ประมูลแบบส่วนตัว') {
  //   //     return "2";
  //   //   }
  //   //   return "1";
  // }
  Widget inputProductTypes(dynamic product_types_data) {
    List<String>? product_types = [];

    if (product_types_data != null) {
      for (int i = 0; i <= product_types_data.length - 1; i++) {
        // print('${i + 1} ${product_types_data[i]['product_type_text']}');
        product_types.add(product_types_data[i]['product_type_text'].toString());
      }
      // product_types.reversed;
      product_types.add('ทั้งหมด');
      // print("::: ${product_types.length}");
      // product_types.reversed;
      // product_types.add('อื่น ๆ');
      // print("${test} ${product_types.length}");
      // double left = 0,
      //     top = 0,
      //     right = 0,
      //     bottom = 0;
      // print("${product_types_data}");
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

  dynamic selectProductType(dynamic product_type) {
    dynamic check_index_product_types = ProductTypesModel().getProductTypes();
    print("${product_type}");
    // List check_index_product_types = product_type;
    if (check_index_product_types != null) {
      for (int index = 0; index <=
          check_index_product_types.length - 1; index++) {
        if (product_type ==
            check_index_product_types[index]['product_type_text']) {
          return "${index + 1}";
        }
      }
    }
    return 0;
  }

  Widget checkStatusData(dynamic data) {

    // has_data = true;

    if (has_data == true && data == null && data.length == 0) {
      return Center(
          child: AlertDialog(
            title: Column(
              children: [
                CircularProgressIndicator(),
                TimerCountdown(
                  endTime: DateTime.now().add(Duration(seconds: 5)
                  ), enableDescriptions: false,
                  onEnd: () {
                    print("object");
                    has_data = false;
                    setState(() {});
                  },
                  format: CountDownTimerFormat.secondsOnly,
                ),
              ],
            ),
          )
      );
    }

    return Text("ไม่มีข้อมูล");
  }
}
