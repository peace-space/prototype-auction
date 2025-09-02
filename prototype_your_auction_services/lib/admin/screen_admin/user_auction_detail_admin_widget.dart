import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype_your_auction_services/admin/screen_admin/user_auction_list_admin_widget.dart';
import 'package:prototype_your_auction_services/channel/ProductDetailAdminChannel.dart';
import 'package:prototype_your_auction_services/controller/ProductDetailController.dart';
import 'package:prototype_your_auction_services/model/admin_model/ProductDetailModel.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/widget_shared/show_count_down_timer.dart';

import '../../screen/BidLists.dart';
import '../../screen/Login.dart';
import '../../share/ShareUserData.dart';

class UserAuctionDetailAdminWidget extends StatefulWidget {
  @override
  State<UserAuctionDetailAdminWidget> createState() {
    return UserAuctionDetailAdminWidgetState();
  }

}

class UserAuctionDetailAdminWidgetState
    extends State<UserAuctionDetailAdminWidget> {
  var _bid = TextEditingController();
  var max_price;
  Map<String, dynamic> detailAuctionData = {};
  List<dynamic> _imageData = [];
  int indexSelectImage = 0;
  PrivateAuctionAdminModel auctionDetailAdminModel = PrivateAuctionAdminModel();
  late Map auction_data = auctionDetailAdminModel.getAuctionDetailAdminData();

  late Map test;
  // StreamController<int> indexSelectImage = StreamController()

  @override
  void dispose() {

    ProductDetailAdminChannel.closeAdmin(id_auctions: auction_data['id_users']);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("รายละเอียดสินค้า"),
        ),
        body: SafeArea(
          top: true,
          left: true,
          right: true,
          bottom: true,
          child: StreamBuilder(
            stream: ProductDetailAdminChannel
                .connectAdmin(id_auctions: auction_data['id_auctions'])
                .stream,
            builder: (context, snapshot) {
              // print("${snapshot.data}");
              // return Text("${auction_data}");
              if (snapshot.hasError) {
                return Center(
                  child: Text("เกิดข้อผิดพลาด"),
                );
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("ไม่มีข้อมูล"),
                );
              }
              if (snapshot.hasData) {
                try {
                  PrivateAuctionAdminModel auctionDetailAdminModel = PrivateAuctionAdminModel();
                  auctionDetailAdminModel.setConvertToMap(snapshot.data);
                  dynamic data = PrivateAuctionAdminModel.getConvertToMap();
                  if (data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (data != null) {
                    Map auction_detail_data = data['data'];
                    _imageData = auction_detail_data['images'];
                    test = data['data'];
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
                          // Text("${auction_detail_data}"),
                          displayDataAuction(context, auction_detail_data),
                          // SizedBox(height: 500),
                        ],
                      ),
                    );
                  }
                } on Exception catch (e) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },),)
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
          "${ConfigAPI().getImageAuctionApiServerGet(
            image_auction_path: _imageData![indexSelectImage],)}"
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
                  "${ConfigAPI().getImageAuctionApiServerGet(
                      image_auction_path: _imageData[index])}",
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

  Widget displayDataAuction(BuildContext ctx, var data) {
    // max_price = data['max_price'];
    return Padding(
      padding: EdgeInsets.all(19),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("Id Auctions: ${data['id_auctions']}"),
          Text("Id Product: ${data['id_products']}"),
          Text("ลบสินค้าและข้อมูลที่เกี่ยวข้อง เช่น ผู้ประมูล"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                onDeleteProduct(id_products: data['id_products']);
              }, child: Text("ลบสินค้าของผู้ใข้งาน")),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("เหลือเวลา: ", style: headText()),
              countDownDetail(context, data['end_date_time']),
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

  void onDeleteProduct({required var id_products}) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          scrollable: false,
          title: Text("ลบสินค้าผู้ใช้งาน"),
          content: Text("ยืนยันการลบสินค้าผู้ใช้งานหรือไม่ ??"),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => UserAuctionListAdminWidget(),));
            }, child: Text("ยกเลิก")),
            TextButton(onPressed: () {
              ProductDetailController().onDeleteProductAdmin(
                  id_products: id_products);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => UserAuctionListAdminWidget(),));
            }, child: Text("ตกลง"))
          ],
        ),);
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

  Widget onBit(var id_users_owner) {
    // return checkProductOwner();
    // print(id_users_owner.toString());
    // return Text("${isProductOwner(id_users_owner)}");
    if (isProductOwner(id_users_owner)) {
      return Text("เจ้าของสินค้า ไม่สามารถเสนอราคาได้");
      // return ElevatedButton(onPressed: () {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => MyAuctions(),));
      // }, child: Text("หน้าจัดการร้านค้า"));
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
                      // submitOnBidding();
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

}