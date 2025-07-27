import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/Chat.dart';
import 'package:prototype_your_auction_services/share/ApiPathServer.dart';
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

  Stream<List<dynamic>> streamChatData() async* {
    String url = ApiPathServer().getChatRoomsServerGet(
        id_users: ShareData.userData['id_users']);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    List<dynamic> data = resData['data'];
    yield data;
    setState(() {});
  }

  Widget streamChatListData(BuildContext ctx) {
    return StreamBuilder(
      stream: streamChatData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("เกิดข้อผิดพลาด ${snapshot.hasError}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: CircularProgressIndicator(),
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
                    onTap: () => goToChat(),
                    title: Text("${data}"),
                  ),
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

  void goToChat() {
    var route = MaterialPageRoute(
      builder: (ctx) => Chat(),
    );
    Navigator.push(context, route);
  }
}



