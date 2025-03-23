import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prototype_your_auction_services/screen/AppBar.dart';
import 'package:prototype_your_auction_services/screen/Chat.dart';

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
    String url = "https://your-auction-services.com/prototype-auction/api-pa/api/user";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final resData = jsonDecode(response.body);
    List<dynamic> data = resData['data'];
    yield data;
  }

  Widget streamChatListData(BuildContext ctx) {
    return StreamBuilder(
      stream: streamChatData(),
      builder: (context, snapshot) =>
          ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              if (snapshot.hasError) {
                return Text("Error ${snapshot.hasError}");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data?[index];
                return Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    onTap: () => goToChat(ctx, data['id_users']),
                    title: Text("${data['name']}"),
                  ),
                );
              }
            },
          ),
    );
  }

  void goToChat(BuildContext ctx, id_user) {
    var route = MaterialPageRoute(
      builder: (ctx) => Chat(id_user),
    );
    Navigator.push(ctx, route);
  }
}



