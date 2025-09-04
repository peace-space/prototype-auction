import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/Chat.dart';
import 'package:prototype_your_auction_services/share/ConfigAPI.dart';
import 'package:prototype_your_auction_services/share/ShareChatData.dart';
import 'package:prototype_your_auction_services/share/ShareProductData.dart';
import 'package:prototype_your_auction_services/share/ShareUserData.dart';
import 'package:prototype_your_auction_services/share/createDrawerShareWidget.dart';

class ChatList extends StatefulWidget {
  State<ChatList> createState() {
    return ChatListState();
  }
}

class ChatListState extends State<ChatList> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatList"),
        actions: [

        ],
      ),
      body: streamChatListData(context),
      drawer: createDrawer(context),
    );
  }

  // Stream<List<dynamic>> streamChatData() async* {
  Stream<dynamic> streamChatData() async* {
    try {
      String url = ConfigAPI().getChatRoomsServerGet(
          id_users: ShareData.userData['id_users'], id_products: ShareProductData.productData['id_products']);

      print("${ShareProductData.productData['id_products']}");
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      final resData = jsonDecode(response.body);

      // print("object");
      List<dynamic> data = resData['data'];
      yield data;
      setState(() {});
    } on Exception catch (e) {
      yield null;
    }
  }

  Widget streamChatListData(BuildContext ctx) {
    return StreamBuilder(
      stream: streamChatData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("เกิดข้อผิดพลาด ${snapshot.data}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
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
            return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data?[index];
                return Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                      onTap: () => goToChat(data),
                      title: Column(
                        children: [
                          Image.network(
                            '${ConfigAPI().getImageAuctionApiServerGet(image_auction_path: data['image_path_1'])}',
                          ),
                          Text(
                            "ชื่อ: ${data['first_name_users']} ${data['last_name_users']}",
                          ),
                          Text("")
                        ],
                      )),
                );
            },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  void goToChat(Map<String, dynamic> data) {
    ShareChatData.chatData = data;
    var route = MaterialPageRoute(
      builder: (ctx) => Chat(),
    );
    Navigator.push(context, route);
  }
}



