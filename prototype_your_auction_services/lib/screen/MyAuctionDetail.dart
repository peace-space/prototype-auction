import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/MyAuctions.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';

import 'BidLists.dart';

class MyAuctionDetail extends StatefulWidget {
  State<MyAuctionDetail> createState() {
    return MyAuctionDetailState();
  }
}

class MyAuctionDetailState extends State<MyAuctionDetail> {
  List<dynamic> _imageData = [];
  int indexSelectImage = 0;
  List<dynamic> _receipt = [];
  var _shipping_number = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ShareProductData.productData['name_product']),
      ),
      body: StreamBuilder(
        stream: fetchMyAuctionDetail(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("เกิดข้อผิดพลาด"));
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!;
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
                  myAuctionDetail(data['data_auction']!),
                  SizedBox(height: 8),
                  textButtonGoToBidLists(context),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Center(child: Text("หลักฐานการชำระเงิน", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 8),
                  // showDataBillAuctionImages(data['data_bill']),
                  SizedBox(height: 8),
                  showDataBillAuction(data['data_bill']),
                  SizedBox(height: 8),
                  buttonConfirmVerification(data['data_bill']),
                  SizedBox(height: 8),
                  buttonGoToChat(),
                  SizedBox(height: 500),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
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
        "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image" +
            _imageData![indexSelectImage],
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
            (context, index) =>
            Card(
              child: InkWell(
                onTap:
                    () =>
                {
                  setState(() {
                    indexSelectImage = index;
                  }),
                },
                child: Image.network(
                  "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image" +
                      _imageData[index],
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
                () =>
            {
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
                () =>
            {
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

  Stream<Map<String, dynamic>> fetchMyAuctionDetail() async* {
    await Future.delayed(Duration(seconds: 1));
    // print('Start.detailAuctions');
    // String url =
    //     'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/product-detail/${ShareProductData
    //     .productData['id_auctions']}';
    String api = ApiPathServer().getMyAuctionBillServerGet(
        id_auctions: ShareProductData.productData['id_auctions'].toString());

    print("SSSSSSSSSSSSSSSSSSSS: " + api);

    final uri = Uri.parse(api);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    Map<String, dynamic> data = resData['data'];
    // print("AAAAAAAAAAAAAAAAAAAAAAAAAAA: "+ data['data_bill'].length.toString());
    if (data['data_bill'] != null) {
      if (data['data_bill']['image_bill'] != null) {
        _receipt = data['data_bill']['image_bill'];
        // print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG: " + _receipt.length.toString());
      }
    }
    print("nnnnn");
    yield data;
    setState(() {
      _imageData = data['images'];
    });
    print('End.detialAuctions');
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

  // Widget countdown() {
  //   final start_date_time_data = ShareProductData
  //       .productData['start_date_time'];
  //   final end_date_time_data = ShareProductData.productData['end_date_time'];
  //
  //   // print(detailAuctionData.toString());
  //   print(end_date_time_data.toString());
  //   var min;
  //   var end_date_time = DateTime.parse(end_date_time_data);
  //
  //   var date_tiem_difference = end_date_time.difference(DateTime.now());
  //   // print("aaaaaaaaaaaaaaa: " + date_tiem_difference.toString());
  //   var countdown = TimerCountdown(
  //     endTime: DateTime.now().add(
  //       Duration(seconds: date_tiem_difference.inSeconds),
  //     ),
  //     format: CountDownTimerFormat.daysHoursMinutesSeconds,
  //     enableDescriptions: true,
  //     spacerWidth: 5,
  //     timeTextStyle: TextStyle(fontSize: 21, color: Colors.red, height: 0),
  //     daysDescription: "day",
  //     hoursDescription: "hour",
  //     minutesDescription: "min",
  //     secondsDescription: "sec",
  //     descriptionTextStyle: TextStyle(height: 0),
  //     colonsTextStyle: TextStyle(fontSize: 21, color: Colors.red),
  //   );
  //   // print("aaaaaaaaaaa: " + );
  //   return countdown;
  // }

  Widget textButtonGoToBidLists(BuildContext ctx) {
    return TextButton(
      onPressed: () => {goToBidLists(ctx)},
      child: Text("ผู้ร่วมประมูล"),
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
          context, MaterialPageRoute(builder: (context) => MyAuctions(),));
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

  Widget buttonConfirmVerification(dynamic data_bill) {
    // print("${id_payment_status_types}");
    try {
      var data = data_bill['data'];

      if (data != null) {
        var id_payment_status_types = data['id_payment_status_types'];

        if (id_payment_status_types == 2) {
          return ElevatedButton(onPressed: () =>
          {
            showInputDataConfirmVerification(data)
          }, child: Text("ยืนยันการตรวจสอบ")
          );
        }
      } else {
        return Center(child: Text("ไม่มีข้อมูลการชำระเงิน"));
      }
    } on Exception catch (e) {
      return Text("");
    }

    return Text("");

  }

  void showInputDataConfirmVerification(dynamic data_bill) async {
    // if (data_auction['']) {
    //
    // }

    showDialog(context: context, builder: (context) =>
        Dialog(
          child: Scaffold(
            appBar: AppBar(
              title: Text("ยืนยันการตรวจสอบ"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text("กรุณาเพิ่มหมายเลขพัสดุก่อนยืนยันการตรวจสอบ"),
                  SizedBox(height: 8,),
                  inputShippingNumber(),
                  SizedBox(height: 8,),
                  submitButtonShippingNumberAndConfirmVerification(data_bill),
                ],
              ),
            ),
          ),),
    );
  }

  TextField inputShippingNumber() {
    return TextField(
      controller: _shipping_number,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("กรอกเลขพัสดุ"),
          hintText: "กรอกเลขพัสดุ"
      ),
    );
  }

  ElevatedButton submitButtonShippingNumberAndConfirmVerification(
      dynamic data_bill) {
    return ElevatedButton(onPressed: () =>
    {
      showDialog(
        barrierDismissible: false,
        context: context, builder: (context) =>
          AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Text("ยืนยันการตรวจสอบ"),
            actions: [
              TextButton(onPressed: () =>
              {
                Navigator.of(context).pop()
              }, child: Text("ยกเลิก")),
              TextButton(onPressed: () =>
              {
                Navigator.of(context).pop(),
                onSubmitShippingNumberAndConfirmVerification(data_bill)
              }, child: Text("ตกลง")),
            ],
          ),),
    }, child: Text("ยืนยัน")
    );
  }

  void onSubmitShippingNumberAndConfirmVerification(
      Map<String, dynamic> data_bill) async {
    Map<String, dynamic> data = {
      'id_bill_auctions': data_bill['id_bill_auctions'],
      'id_auctions': data_bill['id_auctions'],
      'shipping_number': _shipping_number.text,
    };
    String api = ApiPathServer().getConfirmVerificationServerPost();
    Uri uri = Uri.parse(api);
    final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data)
    );

    if (response.statusCode == 201) {
      Navigator.of(context).pop();
      showDialog(
        barrierDismissible: false,
        context: context, builder: (context) =>
          AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Text("ยืนยันการตรวจสอบเรียบร้อย"),
            actions: [
              TextButton(onPressed: () =>
              {
                Navigator.of(context).pop()
              }, child: Text("ตกลง"))
            ],
          ),);
    } else {
      showDialog(
        barrierDismissible: false,
        context: context, builder: (context) =>
          AlertDialog(
            title: Text("ล้มเหลว"),
            content: Text("กรุณาตรวจสอบความถูกต้องอีกครั้ง"),
            actions: [
              TextButton(onPressed: () =>
              {
                Navigator.of(context).pop()
              }, child: Text("ตกลง"))
            ],
          ),);
    }
  }

  Widget myAuctionDetail(Map<String, dynamic> auction_detail_data) {
    return TextButton(onPressed: () =>
    {
      showAuctionDetail(auction_detail_data)
    }, child: Text("รายละเอียดสินค้า")
    );
  }

  void showAuctionDetail(Map<String, dynamic> auction_detail_data) {
    int max_bid = auction_detail_data['max_price'];
    int shipping_cost = auction_detail_data['shipping_cost'];
    int total_price = max_bid + shipping_cost;

    showDialog(context: context, builder: (context) =>
        Dialog(
            child: Scaffold(
              appBar: AppBar(
                title: Text(""),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      // Text("${auction_detail_data.toString()}"),
                      Center(child: Text("รายละเอียดสินค้า", style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),)),
                      Text(
                          "รหัสการประมูล: A-${auction_detail_data['id_auctions']}"),
                      Text("ประเภทการประมูล: ${auctionType(
                          auction_detail_data['id_auction_types'])}"),
                      Text("ชื่อ: ${auction_detail_data['name_product']}"),
                      Text(
                          "รายละเอียด: ${auction_detail_data['detail_product']}"),
                      Text(
                          "ราคาเริ่มต้น: ${auction_detail_data['start_price']} บาท"),
                      Text(
                          "ราคาสูงสุด: ${auction_detail_data['max_price']} บาท"),
                      Text(
                          "ค่าจัดส่ง: ${auction_detail_data['shipping_cost']} บาท"),
                      Text("ราคารวม: ${total_price.toString()} บาท"),
                      Text(
                          "วันเวลาปิดการประมูล: ${auction_detail_data['end_date_time']}"),
                      Divider(),
                      Center(child: Text(
                        "ข้อมูลบัญชีธนาคารของการประมูลสินค้า", style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),)),
                      SizedBox(height: 8,),
                      Text(
                          "ชื่อบัญชีธนาคาร: ${auction_detail_data['name_bank_account']}"),
                      Text(
                          "เลขบัญชีธนาคาร: ${auction_detail_data['bank_account_number']}"),
                      Text("พร้อมเพย์: ${auction_detail_data['prompt_pay']}"),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(onPressed: () =>
                            {
                              Navigator.of(context).pop()
                            }, child: Text("ปิด")),
                            buttonDeleteProduct(),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            )
        ));
  }

  String auctionType(int id_auction_types) {
    if (id_auction_types == 1) {
      return "ประมูลปกติ";
    }
    if (id_auction_types == 2) {
      return "ประมูลส่วนตัว";
    }
    return "ERROR";
  }

  TextButton deleteAuction() {
    return TextButton(onPressed: () =>
    {
    }, child: Text('ลบสินค้าจากการประมูล'));
  }

  // void onDeleteAuction() {
  //   if ()
  // }

  Widget showDataBillAuctionImages(dynamic data) {
    // print("ZZZZZZZZZZZZZZZZZZZZZZZZZ: " + data['image_bill'][0].toString());
    // return ListView.builder(
    //   itemCount: data['image_bill']!.length,
    //   itemBuilder: (context, index) => Card(
    //   child: Image.network('https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image' + data['image_bill'][index]),
    // ),);
    if (_receipt.length == 0) {
      return Center(child: Text("รอการชำระเงิน"));
    }
    if (_receipt.length != 0) {
      return Container(
          height: 255,
          width: 255,
          child: ListView.builder(

            scrollDirection: Axis.horizontal,
            itemCount: _receipt!.length,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: () =>
                  {
                    showOneBillImage(_receipt[index].toString())
                  },
                  child: Card(
                    child: Image.network(
                      'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image' +
                          _receipt[index], width: 255, height: 255,),
                  ),
                ),)
      );
    }


    return Text("รอการชำระเงิน");
  }

  void showOneBillImage(String image_path) {
    print("AAA:::::::::::::::::::::::::::::::::");
    showDialog(context: context,
        builder: (context) =>
            Dialog(
              child: Image.network(
                  'https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image' +
                      image_path),
            )
    );
  }

  Widget buttonGoToChat() {
    return ElevatedButton(onPressed: () =>
    {
    }, child: Text('แชท'));
  }

  Widget showDataBillAuction(dynamic data) {
    try {
      var customer_data = data['data'];
      if (customer_data != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            // Text("${customer_data.toString()}"),
            Text("รหัสใบเสร็จ: Bill-${customer_data['id_bill_auctions']}"),
            Text(
                "ชื่อผู้รับ: ${customer_data['first_name_users']} ${customer_data['last_name_users']}"),
            Text("อีเมล: ${customer_data['email']}"),
            Text("เบอร์โทร: ${customer_data['phone']}"),
            Text("ที่อยู่ในการจัดส่ง: ${customer_data['address']}"),
            Divider(),
            SizedBox(height: 8,),
            Text("สถานะการจัดส่ง: ${deliveryStatus(
                customer_data['delivery_status'])}"),
            Text("หมายเลขพัสดุ: ${shippingNumber(customer_data)}"),
            Text("ราคารวม: ${customer_data['debts']} บาท"),

          ],
        );
      }
    } on Exception catch (e) {
      return Text("");
    }

    return Text("");
  }

  String deliveryStatus(int delivery_status) {
    if (delivery_status == 1) {
      return "จัดส่งสินค้าแล้ว";
    }
    return "กรุณายืนยันการตรวจสอบ";
  }

  String shippingNumber(Map<String, dynamic> customer_data) {
    if (customer_data['shipping_number'] != null) {
      String shipping_number = customer_data['shipping_number'];
      if (shipping_number != '') {
        return shipping_number;
      }
    }
    return "-";
  }
}