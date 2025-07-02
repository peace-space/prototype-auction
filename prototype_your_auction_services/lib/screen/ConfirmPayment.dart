import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';

class ConfirmPayment extends StatefulWidget {
  State<ConfirmPayment> createState() {
    return ConfirmPaymentState();
  }
}

class ConfirmPaymentState extends State<ConfirmPayment> {
  List<dynamic> _imageData = [];
  int indexSelectImage = 0;
  Map<String, dynamic> bill_auction_data = {};

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
          "แจ้งชำระเงิน: Bill-${ShareProductData.productData['id_bill_auctions']
              .toString()}")),
      body: StreamBuilder(
        stream: fetchBillAuction(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("เกิดข้อผิดพลาด"));
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
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
                  buttonDetailAuction(),
                  Divider(),
                  displayConfirmPayment(),
                  SizedBox(height: 8,),
                  buttonGoToChat(),
                  buttonInsertReceipt(),
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

  Widget displayConfirmPayment() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("รหัสใบ้แจ้งชำระเงิน: "),
              Text("Bill-${bill_auction_data['id_bill_auctions']}")
            ],
          ),
          Row(
            children: [
              Text("ชื่อผู้เปิดประมูล: "),
              Text(
                  "${bill_auction_data['first_name_users']} ${bill_auction_data['last_name_users']}")
            ],
          ),
          Row(
            children: [
              Text("อีเมลผู้เปิดประมูล: "),
              Text("${bill_auction_data['email']}")
            ],
          ),
          Row(
            children: [
              Text("ชื่อบัญชีธนาคาร: "),
              Text("${bill_auction_data['name_bank_account']}")
            ],
          ),
          Row(
            children: [
              Text("เลขบัญชีธนาคาร: "),
              Text("${bill_auction_data['bank_account_number']}")
            ],
          ),
          Row(
            children: [
              Text("บัญชีพร้อมเพย์: "),
              Text("${bill_auction_data['prompt_pay']}")
            ],
          )
        ],
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
            (context, index) => Card(
              child: InkWell(
                onTap:
                    () => {
                      setState(() {
                        indexSelectImage = index;
                      }),
                    },
                child: Image.network(
                  "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image" +
                      _imageData[index],
                ),
                // child: Image.network(
                //   'http://192.168.1.248/001.Work/003.Project-2567/Prototype-Your-Auction-Services/api-prototype-your-auction-service/public/api/v1/get-image' +
                //       _imageData[index],
                // ),
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

  Stream<List<dynamic>> fetchBillAuction() async* {
    Future.delayed(Duration(seconds: 5));
    print("Start FetchBillAuction");
    // print(ShareProductData.productData['id_bill_auctions']);
    ApiPathServer apiServerPath = ApiPathServer();
    // print("TETTT");
    String api = apiServerPath.getBillAuctionApiServerGet(
        id_bill_auction: ShareProductData.productData['id_bill_auctions']
            .toString());
    // print(api);
    final uri = Uri.parse(api);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      // print(data['images'].toString());
      // print(data['message'].toString());

      // print("aaaaaaaaa: " + _imageData[1].toString());
      yield data['data'];
      setState(() {
        _imageData = data['images'];
        bill_auction_data = data['data'][0];
      });
    } else {
      print("ERROR. fetchBillAuction: Status = ${response.statusCode
          .toString()}");
    }

    print("End FetchBillAuction");
  }

  Widget buttonDetailAuction() {
    return TextButton(onPressed: () =>
    {
      showDetailAuction()
    }, child: Text("รายละเอียดสินค้า"));
  }

  void showDetailAuction() {
    showDialog(context: context, builder: (context) =>
        Dialog(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text("No.Bill-${bill_auction_data['id_bill_auctions']
                      .toString()}"),
                  Text("ชื่อสินค้า: ${bill_auction_data['name_product']}"),
                  Text(
                      "ชื่อผู้เปิดประมูล: ${bill_auction_data['first_name_users']} ${bill_auction_data['last_name_users']}"),
                  Text("รายละเอียดสินค้า:"),
                  Text("${bill_auction_data['detail_product']}")
                ],
              ),
            ),
          ),
        ),);
  }

  Widget buttonGoToChat() {
    return ElevatedButton(onPressed: () => {}, child: Text("แชท"));
  }

  Widget buttonInsertReceipt() {
    return ElevatedButton(onPressed: () => {}, child: Text("เพิ่มใบเสร็จ"));
  }

  void insertReceiptImages() {

  }

  TextStyle textTopicStyle() {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold
    );
  }
}
