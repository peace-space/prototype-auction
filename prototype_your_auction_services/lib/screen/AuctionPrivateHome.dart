import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

class AuctionPrivateHome extends StatefulWidget {
  State<AuctionPrivateHome> createState() {
    return AuctionPrivateHomeState();
  }
}

class AuctionPrivateHomeState extends State<AuctionPrivateHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ประมูลส่วนตัว")),
      body: StreamBuilder(
          stream: fetchPrivateAuctionGroupData(),
        builder:
            (context, snapshot) {
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
            return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data![index];
                  return Card(
                      child: Stack(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              showImage(data['image_path_1']),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data['name_product']}"),
                                  Text("${data['max_price']}"),
                                  Text("เวลา"),
                                  Text("data"),
                                  Text("data"),
                                  Text("data"),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                              Text("data"),
                            ],
                          )
                        ],
                      )
                  );
                }
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
      drawer: createDrawer(context),
    );
  }

  Stream fetchPrivateAuctionGroupData() async* {
    String api = ApiPathServer().getPrivateAuctionGroupServerGet(
        id_users: ShareData.userData['id_users']);
    Uri uri = Uri.parse(api);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    // print("${resData.toString()}");
    yield resData['data'];
    setState(() {});
  }

  Widget showImage(String image_path) {
    return Container(
        height: 150,
        width: 150,
        child: Image.network(ApiPathServer().getImageAuctionApiServerGet(
            image_auction_path: image_path)));
  }
}
