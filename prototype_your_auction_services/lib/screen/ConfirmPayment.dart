import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';

class ConfirmPayment extends StatefulWidget {
  State<ConfirmPayment> createState() {
    return ConfirmPaymentState();
  }
}

class ConfirmPaymentState extends State<ConfirmPayment> {
  List<dynamic> _imageData = [];
  List<dynamic> _bill_images = [];
  List<File?> _receipt = [];
  int indexSelectImage = 0;
  Map<String, dynamic> bill_auction_data = {};
  String message = '';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "แจ้งชำระเงิน: Bill-${ShareProductData.productData['id_bill_auctions']
              .toString()}",
        ),
      ),
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
                  SizedBox(height: 8),
                  buttonGoToChat(),
                  buttonInsertReceipt(),
                  buttonDeleteReceiptImage(),
                  displayReceiptImage(),
                  buttonSubmit(),
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
              Text("สถานะการแจ้งชำระเงิน: ${paymentStatus(
                  bill_auction_data['id_payment_status_types'])}"),
            ],
          ),
          Row(
            children: [
              Text("รหัสใบ้แจ้งชำระเงิน: "),
              Text("Bill-${bill_auction_data['id_bill_auctions']}"),
            ],
          ),
          Row(
            children: [
              Text("ชื่อผู้เปิดประมูล: "),
              Text(
                "${bill_auction_data['first_name_users']} ${bill_auction_data['last_name_users']}",
              ),
            ],
          ),
          Row(
            children: [
              Text("อีเมลผู้เปิดประมูล: "),
              Text("${bill_auction_data['email']}"),
            ],
          ),
          Row(
            children: [
              Text("ชื่อบัญชีธนาคาร: "),
              Text("${bill_auction_data['name_bank_account']}"),
            ],
          ),
          Row(
            children: [
              Text("เลขบัญชีธนาคาร: "),
              Text("${bill_auction_data['bank_account_number']}"),
            ],
          ),
          Row(
            children: [
              Text("บัญชีพร้อมเพย์: "),
              Text("${bill_auction_data['prompt_pay']}"),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text("ราคา: "),
              Text("${bill_auction_data['debts']} "),
              Text("บาท"),
            ],
          ),
          Row(
            children: [
              Text("สถานะการจัดส่ง: "),
              Text("${deliveryStatus(bill_auction_data['delivery_status'])}"),
            ],
          ),
          Row(
            children: [
              Text("เลขพัสดุ: "),
              Text("${shippingNumber()}"),
            ],
          ),
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

  Stream<Map<String, dynamic>> fetchBillAuction() async* {
    // Future.delayed(Duration(seconds: 5));
    print("Start FetchBillAuction");
    // print(ShareProductData.productData['id_bill_auctions']);
    ApiPathServer apiServerPath = ApiPathServer();
    // print("TETTT");
    String api = apiServerPath.getBillAuctionApiServerGet(
      id_bill_auction:
      ShareProductData.productData['id_bill_auctions'].toString(),
    );
    // print(api);
    final uri = Uri.parse(api);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      // print(data['images'].toString());
      // print(data['message'].toString());

      // print("aaaaaaaaa: " + _imageData[1].toString());
      if (data['bill_images'] != null) {
        _bill_images = data['bill_images'];
      }
      yield data['data'];
      setState(() {
        _imageData = data['images'];
        bill_auction_data = data['data'];
      });
    } else {
      print(
        "ERROR. fetchBillAuction: Status = ${response.statusCode.toString()}",
      );
    }

    print("End FetchBillAuction");
  }

  Widget buttonDetailAuction() {
    return TextButton(
      onPressed: () => {showDetailAuction()},
      child: Text("รายละเอียดสินค้า"),
    );
  }

  void showDetailAuction() {
    showDialog(
      context: context,
      builder:
          (context) =>
          Dialog(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Text(
                      "No.Bill-${bill_auction_data['id_bill_auctions']
                          .toString()}",
                    ),
                    Text("ชื่อสินค้า: ${bill_auction_data['name_product']}"),
                    Text(
                      "ชื่อผู้เปิดประมูล: ${bill_auction_data['first_name_users']} ${bill_auction_data['last_name_users']}",
                    ),
                    Text("รายละเอียดสินค้า:"),
                    Text("${bill_auction_data['detail_product']}"),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget buttonGoToChat() {
    return ElevatedButton(onPressed: () => {}, child: Text("แชท"));
  }

  Widget buttonInsertReceipt() {
    int id_payment_status_types = bill_auction_data['id_payment_status_types'];
    if (id_payment_status_types == 1) {
      return ElevatedButton(
        onPressed: () => {selectReceiptImage()},
        child: Text("เพิ่มใบเสร็จ"),
      );
    }

    return Text("");
  }

  void onInsertReceiptImages() async {
    if (_receipt.length != 0) {
      // ApiPathLocal apiPathLocal = ApiPathLocal();
      // String api = apiPathLocal.getInsertReceiptBillAuctionLocalPost();
      String api = ApiPathServer().getInsertReceiptBillAuctionPost();
      Uri uri = Uri.parse(api);
      final request = http.MultipartRequest('POST', uri);

      List<dynamic> stream = [];
      List<dynamic> multiport = [];

      for (int i = 0; i < _receipt.length; i++) {
        stream.add(File(_receipt[i]!.path.toString()).readAsBytesSync());

        multiport.add(
          http.MultipartFile.fromBytes(
            'payment_proof_images_path_${i + 1}',
            stream[i],
            filename: _receipt[i]!.path,
          ),
        );

        request.files.add(multiport[i]);
        request.fields['payment_proof_images_path_${i + 1}'] =
            request.files[i].toString();
      }

      Map<String, dynamic> data = {
        'id_result_auctions': ShareProductData
            .productData['id_result_auctions'].toString(),
        'id_auctions': ShareProductData.productData['id_auctions'].toString()
      };

      request.fields['id_result_auctions'] =
          data['id_result_auctions'].toString();
      request.fields['id_auctions'] = data['id_auctions'];

      final response = await request.send();

      if (response.statusCode == 201) {
        print("STATUS CODE: ${response.statusCode.toString()}");
        // showDialog(
        //     context: context,
        //     builder: (context) => ,
        // );
      } else {
        print("\n\n\n\n\n");

        print("Error: StatusCode = ${response.statusCode.toString()}");

        print("\n\n\n\n\n");
      }
    } else {
      setState(() {
        message = 'กรุณาเพิ่มใบเสร็จชำระเงิน';
      });

      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Text("กรุณาเพิ่มใบเสร็จชำระเงิน"),
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

  void selectReceiptImage() async {
    int maxImageListLength = 2;
    if (_receipt.length <= maxImageListLength - 1) {
      final _picker = ImagePicker();

      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _receipt.add(File(pickedFile.path));
        });
        print("end.aaaaa");
      }
    }
  }

  Widget displayReceiptImage() {
    print("ssssssssssssssssssssssssssssssssssssssss" +
        bill_auction_data['id_payment_proof_images'].toString());
    int id_payment_status_types = bill_auction_data['id_payment_status_types'];

    if (_bill_images == null) {
      return Text('');
    }

    if (id_payment_status_types == 1) {
      return Container(
        width: 100,
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _receipt.length,
          itemBuilder:
              (context, index) =>
              Card(
                child: InkWell(
                  onTap:
                      () =>
                  {
                    showDialogReceiptImage(index)
                  },
                  child: (_receipt.length == 0) ? Center(
                      child: Text("เกิดข้อผิดพลาด")) : Image.file(
                      _receipt[index]!),
                ),
              ),
        ),
      );
    }
    if (id_payment_status_types == 2 || id_payment_status_types == 3) {
      return Container(
        width: 100,
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _bill_images.length,
          itemBuilder:
              (context, index) =>
              Card(
                child: InkWell(
                  onTap:
                      () =>
                  {
                    showDialogReceiptImage(index)
                  },
                  child: (_bill_images.length == 0) ? Center(
                      child: Text("เกิดข้อผิดพลาด")) : Image.network(
                    "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image" +
                        _bill_images![index],
                  ),
                ),
              ),
        ),
      );
    }

    return Text("");
  }

  void showDialogReceiptImage(int index) {
    int id_payment_status_types = bill_auction_data['id_payment_status_types'];

    if (id_payment_status_types == 1) {
      showDialog(
        context: context, builder: (context) =>
          Dialog(
              child: (_bill_images.length == 0) ? Center(
                  child: Text("เกิดข้อผิดพลาด")) : Image.file(_receipt[index]!)
          ),
      );
    }

    if (id_payment_status_types == 2 || id_payment_status_types == 3) {
      showDialog(
        context: context, builder: (context) =>
          Dialog(
            child: (_bill_images.length == 0) ? Center(
                child: Text("เกิดข้อผิดพลาด")) : Image.network(
              "https://prototype.your-auction-services.com/git/api-prototype-your-auction-service/api/v1/get-image" +
                  _bill_images![index],
            ),
          ),
      );
    }

  }

  Widget buttonDeleteReceiptImage() {
    int id_payment_status_types = bill_auction_data['id_payment_status_types'];
    if (id_payment_status_types == 1) {
      return ElevatedButton(onPressed: () =>
      {
        deleteReceiptImage()
      }, child: Text("ลบรูปภาพ")
      );
    }

    return Text("");
  }

  void deleteReceiptImage() {
    _receipt.removeLast();
  }

  TextStyle textTopicStyle() {
    return TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }

  String paymentStatus(int payment_status_types) {
    if (payment_status_types == 2) {
      return "กำลังตรวจสอบ";
    } else if (payment_status_types == 3) {
      return "ยืนยันการชำระเงินแล้ว";
    }
    return "รอการชำระเงิน";
  }

  Widget buttonSubmit() {
    int id_payment_status_types = bill_auction_data['id_payment_status_types'];
    print("AAAAAA: " + id_payment_status_types.toString());

    if (id_payment_status_types == 1) {
      return ElevatedButton(
          onPressed: () =>
          {
            onInsertReceiptImages()
          }, child: Text("ยืนยันการชำระเงิน")
      );
    }

    return Text("");

  }

  String deliveryStatus(int delivery_status) {
    if (delivery_status == 1) {
      return "จัดส่งสินค้าแล้ว";
    }
    return "รอการชำระเงิน";
  }

  String shippingNumber() {
    if (bill_auction_data['shipping_number'] != null) {
      String shipping_number = bill_auction_data['shipping_number'];
      if (shipping_number != '') {
        return shipping_number;
      }
    }
    return "-";
  }
}
